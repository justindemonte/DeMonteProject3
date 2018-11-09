#!/usr/bin/env nextflow

process download_data {

    output:
    file "./data/p2_abstracts/*.txt" into file_channel

    """
    #!/usr/bin/env bash

    git clone https://github.com/biodatascience/datasci611.git && \
    cd datasci611 && \
    git checkout gh-pages
    """

}

process read_files {
    container 'cgrlab/tidyverse'
    
    input:
    file f from file_channel

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
