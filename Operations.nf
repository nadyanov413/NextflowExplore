#!/usr/bin/env nextflow
nextflow.enable.dsl=2

//process list Operations
process ListOperations {
    publishDir 'results', mode: 'copy'
    input:
    tuple val(numbers), val(doubled), val(sum),val(evens), val(resultsFile)
    output:
    path resultsFile
    script:
    """
    echo "Input numbers: ${numbers}" > ${resultsFile} 
    echo "Doubles input: ${doubled}" >> ${resultsFile}
    echo "Sum of original input: ${sum}" >> ${resultsFile}
    echo "Even values of original input: ${evens}" >> ${resultsFile}
    """
}

//process map operations 
process MapDump{
    publishDir 'results', mode: 'copy'
    input:
    val fruit_map
    val fruitFile
    output:
    path fruitFile
    script:
    """
    echo "Fruit Map: ${fruit_map}" > ${fruitFile}
    """
}

process PersonMap{
    publishDir 'results', mode: 'copy'
    input:
    val person
    val personFile
    output:
    path personFile 
    script:
    """
    echo "Persons name is: ${person.name}" > ${personFile}
    echo "Persons age is: ${person.age}" >> ${personFile}
    echo "${person.name}:${person.age}" >> ${personFile}
    """

}

// process Square Number through channel.of(1,2,3,4)
process SquareNumber{
    publishDir 'results', mode: 'copy'
    input:
    tuple val(number), val(squareFile)
    output:
    path squareFile
    script:
    """
    echo "Squaring numbers..." > ${squareFile}
    for n in ${number.join(' ')}; do
    echo "Square of \$n is \$((n * n))" >> ${squareFile}
    done
    
    """
    //echo "Square of ${number} is \$((${number} * ${number}))" > ${squareFile}
    }

//Process for working with channel.fromPath and being able to copy it into an output file 
process CountLines{
    publishDir 'results', mode: 'copy'
    input:
    tuple path(input_file), val(countLinesFile)
    output:
    path countLinesFile
    script:
    """
    echo "File: ${input_file}" > ${countLinesFile}
    wc -l < ${input_file} >> ${countLinesFile}
    """
}

//process to work with the Channel.fromList() 
process Greet{
    publishDir 'results', mode: 'copy'
    input:
    tuple val(names), val(greetFile)
    output:
    path greetFile
    script:
    """
    echo "Greetings:" > ${greetFile}
    for name in ${names.join(' ')}; do
        echo "Hello: \$name" >> ${greetFile}
    done
    """

}



//workflow 
workflow{
    // WorkFlow for the list operations
    def numbers = [1,2,3,4,5]
    def doubled = numbers.collect {it * 2}
    def sum = numbers.sum()
    def evens = numbers.findAll{it % 2 == 0}
    def resultsFile = 'resultsFile.txt'
    def input_ch = Channel.of([numbers, doubled, sum,evens,resultsFile])
    ListOperations(input_ch)
    
    //WorkFlow for the fruit map operations 
    def fruits = [apple: 1.2, bannana: 0.5, grapes: 3.0]
    def fruit_ch = Channel.of("fruit.txt")
    MapDump(fruits, fruit_ch)

    //Workflow for person map oprtations
    def person = [name: 'Grayson', age: 50]
    def personFile_ch = Channel.of("personFile.txt")
    person.each{key, value -> println "$key: $value"}
    PersonMap(person, personFile_ch)

    //Workflow for channel.of(1, 2, 3, 4)
    def number = [1,2,3,4]
    def fileName = "squareFile.txt"
    Channel.of([number, fileName]) | SquareNumber
    
    //Channel.of([4, "squareFile.txt"],
    //      [3, "squareFile.txt"]                        
    //                               )
    //|SquareNumber

    // Workflow for channel.fromPath()
    Channel.fromPath('numbers.txt')
            .map{file -> [file, "countLinesFile.txt"]} 
            | CountLines

    //Workflow for Channel.fromList()
    def names = ['nadya', 'olga', 'andrey']
    def greetFile = "greetFile.txt"
    Channel.fromList([[names, greetFile]]) | Greet

    //Workflow for Double it, implict return 
    Channel.of(5)
        .map {doubleIt(it)}
        .view {"Double result: $it"}


}
    //String Interpolation
    def name = "Nadya"
    println "Hello $name!"

    println "Result: ${2 * 2    }"

    //Groovy String Handeling 
    //single quotes
    println 'Value: $x'

    //double quotes
    def x = 5
    println "Value: $x"

    //Multi Line string come in three quotes

    //Shell Command Executions
    def result = "ls -l".execute().text
    println "Files in directory: ${result}"

    //Variable Scope
    def y = 12000;
    def closure = {println y}
    closure()

    //Lazy Evaluation
    def c = Channel.of(1,2,3)
            .map{it * 2}    
    //
    c.view{ t -> "item: $t"}

//Implicit Return 
    def doubleIt(x){
        x * 2
        
    }

