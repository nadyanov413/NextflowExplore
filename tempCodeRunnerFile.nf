process Greet{
    publishDir 'results', mode: 'copy'
    input:
    tuple val(names), val(greetFile)
    output:
    path greetFile, append: true
    script:
    """
    echo "Hello: ${names}" >> ${greetFile}
    """

}