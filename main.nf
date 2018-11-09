#!/usr/bin/env nextflow

// need to fix the (default) params.file_dir directory ?
params.out_dir = 'data/'
params.out_file = 'abstracts.csv'


process download_data {

    

    """

    #!/usr/bin/env bash

    git clone https://github.com/biodatascience/datasci611.git && \
    cd datasci611 && \
    git checkout gh-pages && \
    cd data && \
    cd p2_abstracts
    """

}

/*
file_channel = Channel.fromPath('datasci611/data/p2_abstracts/abs*.txt')

process get_seq_length {

    // this container includes Tidyverse and stringr 

    container 'cgrlab/tidyverse'

    input:
    file f from file_channel

    output:
    stdout each_abstract

    """
    #!/usr/local/bin/Rscript
    temp <- lapply($f, read_file)
    """
}


process get_seq_length {

    // this container has Tidyverse and stringr installed

    container 'cgrlab/tidyverse'

    input:
    val temp from each_abstract

    output:
    file params.out_file into out_csv

    """
    #!/usr/local/bin/Rscript

    csv <- write_csv($val)

    """
}
*/