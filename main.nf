#! /usr/bin/env nextflow

params.in_files = 'data/abs*'

in_txt = Channel.fromPath( params.in_files )

process read_in_files {

    container �crglab/tidyverse�    

    input:
    file f from in_txt

    output:
    file '*.csv' into csv_out

    script:
    """
    Rscript $baseDir/bin/getCollaborators.R $f 
    """
}


process plot_nucleus_counts {
    container 'cgrlab/tidyverse'
    publishDir 'data', mode: 'copy'
    
    input:
    file i from csv_out.collectFile(name: 'collaborators.csv', newLine: true)

    output:
    file 'topTen.csv' into out_file

    script:
    """
    Rscript $baseDir/bin/getTopTen.R $i
    """

}
