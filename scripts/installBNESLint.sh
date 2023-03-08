#!/bin/bash

# 检查 Node.js 是否安装
if ! command -v node &> /dev/null
then
    echo "Node.js 未安装，请先安装"
    exit 1
fi

# 接受参数
type=$1

# 参数验证
if [ "$type" != "vue" ] && [ "$type" != "react" ] && [ "$type" != "express" ] && [ "$type" != "nest" ]; then
    echo '请传入正确参数项目框架类型: vue, react, express, nest'
    exit 1
fi


# PS3="请输入项目框架类型选项的数字: "
# options=("vue" "react" "express" "退出")

# select opt in "${options[@]}"
# do
#     case $opt in
#         "vue")
#             echo "开始 vue 项目初始化"
#             type="vue"
#             break
#         ;;
#         "react")
#             echo "开始 react 项目初始化"
#             type="react"
#             break
#         ;;
#         "express")
#             echo "开始 express 项目初始化"
#             type="express"
#             break
#         ;;
#         "退出")
#             echo "Exiting menu"
#             exit 1
#         ;;
#         *)
#             echo "无效选项 $REPLY"
#         ;;
#     esac
# done

# pnpm
# if  command -v pnpm &> /dev/null
# then
#     read -p "检测到 pnpm, 是否使用 pnpm 安装依赖? (y/n): --> " pnpm
# fi

basePkg="eslint prettier eslint-config-prettier eslint-plugin-prettier lint-staged yorkie commitlint commitlint-config-gitmoji"

# 设置框架类型和依赖
if [ "$type" == "vue" ]; then
    pkg="eslint-plugin-vue @babel/eslint-parser"
    elif [ "$type" == "react" ]; then
    pkg="eslint-config-airbnb eslint-plugin-import @babel/eslint-parser"
    elif [ "$type" == "express" ]; then
    pkg="eslint-config-airbnb eslint-plugin-import @babel/eslint-parser"
    elif [ "$type" == "nest" ]; then
    pkg="typescript-eslint/eslint-plugin @typescript-eslint/parser"
fi

echo "正在安装依赖..."

echo "安装依赖: $basePkg $pkg"

npm install $basePkg $pkg --save-dev
echo "相关依赖安装完成"

# 生成配置文件
echo "正在生成配置文件..."

# 创建 .prettierignore 配置文件
function createPrettierConfig() {
cat <<EOF > .prettierrc.js
module.exports = {
  root: true,
  // 一行最多 100 字符
  printWidth: 100,
  // 使用 2 个空格缩进
  tabWidth: 2,
  // 不使用缩进符，而使用空格
  useTabs: false,
  // 行尾需要有分号
  semi: false,
  // 字符串是否使用单引号
  singleQuote: false,
  // 对象的 key 仅在必要时用引号
  quoteProps: "as-needed",
  // 在jsx语法里是否使用单引号
  jsxSingleQuote: false,
  // 末尾不需要逗号
  trailingComma: "none",
  // 大括号内的首尾需要空格
  bracketSpacing: true,
  // 箭头函数 尽可能省略参数
  arrowParens: "avoid",
  // 每个文件格式化的范围是文件的全部内容
  rangeStart: 0,
  rangeEnd: Infinity,
  // 不需要写文件开头的 @prettier
  requirePragma: false,
  // 不需要自动在文件开头插入 @prettier
  insertPragma: false,
  // 使用默认的折行标准
  proseWrap: "preserve",
  // 根据显示样式决定 html 要不要折行
  htmlWhitespaceSensitivity: "ignore",
  // 换行符使用 lf
  endOfLine: "lf"
}
EOF
}

createPrettierConfig

# .editorconfig
cat <<EOF > .editorconfig
# http://editorconfig.org
# 配置详见 http://editorconfig.org
root = true

[*]
#设置缩进风格 （tab是硬缩进  space是软缩进）
indent_style = space
# 缩进的宽度 这里设置为2
indent_size = 2
# 设置换行符  值有 lf 、cr、crlf
end_of_line = lf
# 设置编码
charset = utf-8
# 设置为true以删除换行符前面的任何空白字符
trim_trailing_whitespace = true
# 设为true表示使文件以一个空白行结尾
insert_final_newline = true

[*.md]
# md文件不删除换行符前的字符
trim_trailing_whitespace = false

[Makefile]
indent_style = tab
EOF

# commitlint.config.js
cat <<EOF > commitlint.config.js
module.exports = {
  extends: ["gitmoji"],
  helpUrl:
    "请按格式提交 > '✨ Introduce new features', <emoji><空格><提交信息>: https://banu.feishu.cn/wiki/wikcniS6Q0z94AzXB0Se1M2eNmf",
  rules: {
    "type-case": [0],
    "scope-case": [0],
    "subject-case": [0],
    "subject-full-stop": [0],
    "subject-empty": [0],
    "type-empty": [0]
  }
}
EOF

if [ "$type" = "vue" ]; then
cat <<EOF > .eslintrc.js
module.exports = {
  root: true,
  env: {
    node: true,
    browser: true,
    es6: true
  },
  extends: ["plugin:vue/recommended", "eslint:recommended", "plugin:prettier/recommended"],
  parserOptions: {
    parser: "@babel/eslint-parser"
  },
  rules: {
    // "off" 或 0 - 关闭规则
    // "warn" 或 1 - 开启规则，使用警告级别的错误：warn (不会导致程序退出)
    // "error" 或 2 - 开启规则，使用错误级别的错误：error (当被触发的时候，程序会退出)
  }
}
EOF
fi

if [ "$type" = "react" ]; then
cat <<EOF > .eslintrc.js
module.exports = {
  root: true,
  env: {
    node: true,
    browser: true,
    es6: true
  },
  extends: ["airbnb", "eslint:recommended", "plugin:prettier/recommended"],
  parserOptions: {
    parser: "@babel/eslint-parser"
  },
  rules: {
    // "off" 或 0 - 关闭规则
    // "warn" 或 1 - 开启规则，使用警告级别的错误：warn (不会导致程序退出)
    // "error" 或 2 - 开启规则，使用错误级别的错误：error (当被触发的时候，程序会退出)
  }
}
EOF
fi

if [ "$type" = "express" ]; then
cat <<EOF > .eslintrc.js
module.exports = {
  root: true,
  env: {
    node: true,
    es6: true
  },
  extends: ["airbnb", "eslint:recommended", "plugin:prettier/recommended"],
  parserOptions: {
    parser: "@babel/eslint-parser",
    ecmaVersion: 2020
  },
  rules: {
    camelcase: 0,
    "spaced-comment": 0,
    "import/order": 0,
    "no-unused-vars": 0
    // "off" 或 0 - 关闭规则
    // "warn" 或 1 - 开启规则，使用警告级别的错误：warn (不会导致程序退出)
    // "error" 或 2 - 开启规则，使用错误级别的错误：error (当被触发的时候，程序会退出)
  }
}
EOF
fi

if [ "$type" = "nest" ]; then
cat <<EOF > .eslintrc.js
module.exports = {
  root: true,
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: 2018,
    sourceType: "module"
  },
  plugins: ["@typescript-eslint"],
  extends: ["plugin:@typescript-eslint/recommended", "prettier"],
  rules: {
    "prettier/prettier": "error",
    "@typescript-eslint/explicit-module-boundary-types": "off"
  }
};
EOF
fi

echo "配置文件生成完成"

if [ $? -ne 0 ]; then
    echo "初始化脚本执行失败！请尝试重启编辑器, 如有问题请联系@唐天博"
    exit 1
fi


# 换行
echo ""
echo "脚本执行成功！请重启编辑器!"
echo ""

