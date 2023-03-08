#!/bin/sh

type=$1

# 检查参数是否为空 并提示输入
if [ -z "$type" ]; then
    read -p "请输入项目类型: vue | react | express | nest: --> " type
fi

# 检查类型是否正确
if [ "$type" != "vue" ] && [ "$type" != "react" ] && [ "$type" != "express" ] && [ "$type" != "nest" ]; then
    echo "请输入正确的项目类型: vue | react | express | nest"
    read -p "请输入项目类型: vue | react | express | nest: --> " type
fi

# 检查 Node.js 是否安装
if ! command -v node &> /dev/null
then
    echo "Node.js 未安装，请先安装"
    exit 1
fi

# pnpm
# if  command -v pnpm &> /dev/null
# then
#     read -p "检测到 pnpm, 是否使用 pnpm 安装依赖? (y/n): --> " pnpm
# fi

# 设置框架类型和依赖
if [ "$type" == "vue" ]; then
    pkg="@vue/cli-plugin-eslint eslint prettier eslint-config-prettier eslint-plugin-prettier"
    elif [ "$type" == "react" ]; then
    pkg="eslint prettier eslint-config-prettier eslint-plugin-prettier eslint-plugin-react-hooks"
    elif [ "$type" == "express" ]; then
    pkg="eslint prettier eslint-config-prettier eslint-plugin-prettier"
    elif [ "$type" == "nest" ]; then
    pkg="@nestjs/cli @nestjs/eslint-plugin eslint-config-prettier eslint-plugin-prettier"
else
    echo "无法识别的框架类型"
    exit 1
fi

echo "正在安装依赖..."
npm install $pkg --save-dev
echo "相关依赖安装完成"



# 创建 .eslintrc.js 配置文件
function createEslintConfig() {
  cat <<EOF > .eslintrc.js
module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: ['plugin:vue/essential', 'eslint:recommended', 'prettier'],
  plugins: ['prettier'],
  rules: {
    'prettier/prettier': 'error'
  },
  parserOptions: {
    parser: 'babel-eslint'
  }
}
EOF
}

# 生成配置文件
echo "正在生成配置文件..."
createEslintConfig
# if [ "$1" == "vue" ]; then
#     echo "正在生成 Vue 配置文件..."
#     npx eslint --init
#     elif [ "$1" == "react" ]; then
#     echo "正在生成 React 配置文件..."
#     npx eslint --init
#     elif [ "$1" == "express" ]; then
#     echo "正在生成 Express 配置文件..."
#     npx eslint --init
#     elif [ "$1" == "nest" ]; then
#     echo "正在生成 Nest 配置文件..."
#     npx eslint --init
# fi

# 判断有异常退出
if [ $? -ne 0 ]; then
    echo "初始化脚本执行失败！请尝试重启编辑器, 如有问题请联系@唐天博"
    exit 1
fi


echo "初始化脚本执行成功！"







