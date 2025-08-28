#!/usr/bin/env nextflow
nextflow.enable.dsl=2


/*
 * Use echo to print 'Hello World!' to a file
 */
process ArrayListBuild {
    publishDir 'results', mode: 'copy'
    input:
        path number_input
        val result_output
        
    output:
       path result_output

    script:
    """
   /Users/nadyanovichkova/AlgorithmPractice/vector/ArrayList ${number_input} ${result_output}
    """

}



process MultiplyResults {

    publishDir 'results', mode: 'copy'

    input:
        path result_input
        val newResult_output
     
    output:
        path newResult_output


   script:
    """
    /Users/nadyanovichkova/MyNextFlow/multiply_results ${result_input} ${newResult_output}
    """
}



workflow {
   
     number_ch = Channel.fromPath('numbers.txt')
     result_ch = Channel.of("results.txt")
     newResult_ch = Channel.of("newResults.txt")
                        
    // emit a greeting
    ArrayListBuild(number_ch, result_ch)
    MultiplyResults(ArrayListBuild.out, newResult_ch )
}
