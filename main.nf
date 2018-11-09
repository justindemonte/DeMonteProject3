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
    file f from file_channel.collectFile(name: 'singleFile.txt', newLine: true)

    output:
    file 'abstracts.csv' into out_file

    """
    Rscript $baseDir/bin/DeMonteProject3.R $f     
    """
}

