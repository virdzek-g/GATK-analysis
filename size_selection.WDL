workflow GV_size_selection_workflow {
  File input_bam
  String default_file_prefix
  
  call GV_size_selection {
    input:
      input_bam = input_bam,
      default_file_prefix = default_file_prefix
    }
  output {
    File ds_bam_file = GV_size_selection.ds_bam_file
  }
}

task GV_size_selection {
  Int? extra_disk
  Float? extra_mem
  File input_bam
  String default_file_prefix
  
  Int disk_size = ceil(size(input_bam,"GB") * 2.5 + 50) + select_first([extra_disk,0])
  Float memory = 7.5 + select_first([extra_mem, 0])
  
  command {
    samtools view \
    -h ${input_bam} | awk '($9 >= 0 && $9 <= 150) || /^@/' | samtools view -bS - > ${default_file_prefix}.bam
   


  }
  
  output {
    File ds_bam_file = "${default_file_prefix}.bam"
  }
  
  runtime {
    docker: "us.gcr.io/broad-gotc-prod/genomes-in-the-cloud:2.3.3-1513176735"
    cpu: 2
    memory: memory + " GB"
    disks: "local-disk " + disk_size + " HDD"
  }
}
