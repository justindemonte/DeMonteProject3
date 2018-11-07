#!/usr/bin/env nextflow

// need to fix the (default) params.file_dir directory ?
params.out_dir = 'data/'
params.out_file = 'abstracts.csv'

/*
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
*/


file_channel = Channel.fromPath('datasci611/data/p2_abstracts/abs*.txt')

process read_files {

    // this container includes Tidyverse and stringr 

    container 'cgrlab/tidyverse'

    input:
    file f from file_channel

    output:
    stdout each_abstract

    """
    #!/usr/bin/env Rscript

    myfiles = readr::read_delim($f)
   
    """
}


process test {

    // this container has Tidyverse and stringr installed

    container 'cgrlab/tidyverse'

    input:
    val myfiles from each_abstract.collect()

    output:
    file params.out_file into out_csv

    """
    #!/usr/bin/env Rscript
    write.csv(mylst, file = '$params.out_file')

    """
}

