# localrules: iqtree_dna, iqtree_protein

rule iqtree_dna:
    input:
        concat_aligments_dir_path / concat_fna_filename
    output:
        dir=directory(iqtree_dir_path),
        iqtree=iqtree_dir_path / iqtree_fna_filename
    params:
        iqtree_path=config["iqtree_path"],
        prefix=config["iqtree_fna_prefix"],
        options=config["iqtree_dna_params"]
    log:
        std=log_dir_path / "fna.iqtree.log",
        cluster_log=cluster_log_dir_path / "fna.iqtree.cluster.log",
        cluster_err=cluster_log_dir_path / "fna.iqtree.cluster.err"
    benchmark:
        benchmark_dir_path / "fna.iqtree.benchmark.txt"
    # conda:
    #     "../../%s" % config["conda_config"]
    resources:
        cpus=config["iqtree_threads"],
        time=config["iqtree_time"],
        mem=config["iqtree_mem_mb"]
    shell:
        "mkdir -p {output.dir}; "
        "DIR=$(dirname {input}); "
        "{params.iqtree_path}/iqtree -s {input} -pre {params.prefix} -nt {resources.cpus} {params.options} 1> {log.std} 2>&1; "
        "mv $DIR/{params.prefix}.bionj {output.dir}; "
        "mv $DIR/{params.prefix}.ckp.gz {output.dir}; "
        "mv $DIR/{params.prefix}.log {output.dir}; "
        "mv $DIR/{params.prefix}.mldist {output.dir}; "
        "mv $DIR/{params.prefix}.model.gz {output.dir}; "
        "mv $DIR/{params.prefix}.treefile {output.dir}; "
        "mv $DIR/{params.prefix}.iqtree {output.dir}; "


rule iqtree_protein:
    input:
        concat_aligments_dir_path / concat_faa_filename
    output:
        dir=directory(iqtree_dir_path),
        iqtree=iqtree_dir_path / iqtree_faa_filename
    params:
        iqtree_path=config["iqtree_path"],
        prefix=config["iqtree_faa_prefix"],
        options=config["iqtree_protein_params"]
    log:
        std=log_dir_path / "faa.iqtree.log",
        cluster_log=cluster_log_dir_path / "faa.iqtree.cluster.log",
        cluster_err=cluster_log_dir_path / "faa.iqtree.cluster.err"
    benchmark:
        benchmark_dir_path / "faa.iqtree.benchmark.txt"
    # conda:
    #     "../../%s" % config["conda_config"]
    resources:
        cpus=config["iqtree_threads"],
        time=config["iqtree_time"],
        mem=config["iqtree_mem_mb"]
    shell:
        "mkdir -p {output.dir}; "
        "DIR=$(dirname {input}); "
        "{params.iqtree_path}/iqtree -s {input} -pre {params.prefix} -nt {resources.cpus} {params.options} 1> {log.std} 2>&1; "
        "mv $DIR/{params.prefix}.bionj {output.dir}; "
        "mv $DIR/{params.prefix}.ckp.gz {output.dir}; "
        "mv $DIR/{params.prefix}.log {output.dir}; "
        "mv $DIR/{params.prefix}.mldist {output.dir}; "
        "mv $DIR/{params.prefix}.model.gz {output.dir}; "
        "mv $DIR/{params.prefix}.treefile {output.dir}; "
        "mv $DIR/{params.prefix}.iqtree {output.dir}; "
