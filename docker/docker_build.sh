# 1、构建Java程序，得到jar包
# 2、将jar包拷贝到docker目录中
# 3、构建镜像

#!/bin/bash

# 版本
version="v2.0"

# 生成的jar包后缀
jar_name_suffix=".jar"

function build_image()
{
    work_path=$(pwd)
    echo "当前目录："$work_path

    cd ../
    project_path=$(pwd)
    echo "当前项目路径："$project_path
    jar_name=$1""$jar_name_suffix
    echo "待生成镜像的jar包："$jar_name

    latest_commit_id=$(git rev-parse --short HEAD)
    branch=$(git symbolic-ref --short -q HEAD)

    rm -rf target
    mvn package
    cp $project_path"/target/"$jar_name $project_path"/docker"
    cd $project_path"/docker"

    time=$(date "+%Y%m%d_%H%M%S")
    tag=$version"_"$branch"_"$time"_"$latest_commit_id

    docker_name=$1":"$tag
    sudo docker build -t $docker_name .
}

function test(){
    echo $project_path_prefix
    project_path=$project_path_prefix"/"$1
    echo $project_path
    latest_commitid=$(git rev-parse --short HEAD)
    echo $latest_commitid
}

# 根据各个项目修改
project_name="eureka-server"

# 入口
build_image $project_name
