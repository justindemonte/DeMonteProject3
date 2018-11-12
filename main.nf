#! /usr/bin/env nextflow

params.in_files = 'data/abs*'

in_txt = Channel.fromPath( params.in_files )

process readInFiles {
    container 'crglab/tidyverse'    

    input:
    file f from in_txt

    output:
    file '*.csv' into csv_out

    script:
    """
    Rscript $baseDir/bin/getCollaborators.R $f 
    """
}


process getTopTen {
    container 'cgrlab/tidyverse'
    publishDir 'data', mode: 'copy'
    
    input:
    file i from csv_out.collectFile(name: 'collaborators.csv', newLine: true)

    output:
    file '*.csv' into out_file

    script:
    """
    Rscript $baseDir/bin/getTopTen.R $i
    """

}
