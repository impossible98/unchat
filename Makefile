# 使用POSIX标准的bash作为SHELL，提高跨平台兼容性
SHELL := /bin/bash
# 定义常量
COLOR_RESET ?= \033[0m
COLOR_GREEN ?= \033[32;01m
# 定义变量
GO_VERSION := $(shell go version | awk '{print $$3}' | sed 's/^go//')
NODE_VERSION := $(shell node --version | sed 's/^v//')
YARN_VERSION := $(shell yarn --version | sed 's/^v//')
# 构建项目
build: version
	go build -o ./dist/unchat
# 启动开发服务器
dev:
	go run main.go
# 安装环境
env:
	asdf install
# 格式化代码
fmt:
	yarn run format
# 自动修复代码格式
fix:
	go fmt ./...
	yarn run format:fix
# 确保依赖是最新的
install: version
	go mod tidy
	yarn install --frozen-lockfile
# 查看提交历史记录
log:
	git log --oneline --decorate --graph --all
# 推送代码
push:
	git push
# 打印版本信息
version:
	@echo -e "$(COLOR_GREEN)"
	@echo "=============================="
	@echo "  Go:      v$(GO_VERSION)"
	@echo "  Node.js: v$(NODE_VERSION)"
	@echo "  Yarn:    v$(YARN_VERSION)"
	@echo "=============================="
	@echo -e "$(COLOR_RESET)"
