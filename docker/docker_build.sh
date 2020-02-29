# 1、构建Java程序，得到jar包
# 2、将jar包拷贝到docker目录中
# 3、构建镜像

#!/bin/bash

# 整个项目父路径
project_path_prefix="/home/tim/git/ishou"

# 生成的jar包后缀
jar_name_suffix="0.0.1-SNAPSHOT.jar"

function build_image()
{
    project_path=$project_path_prefix"/"$1
    jar_name=$1"-"$jar_name_suffix
    echo $project_path
    echo $jar_name
    cd $project_path
    rm -rf target
    mvn package
    cp $project_path"/target/"$jar_name $project_path"/docker"
    cd $project_path"/docker"
    time=$(date "+%Y%m%d_%H%M%S")
    tag=$time"_release"
    docker_name=$1":"$tag
    sudo docker build -t $docker_name .
}

function test(){
    echo $project_path_prefix
}

# 根据各个项目修改
project_name="eureka-server"

# 入口
build_image $project_name