PKG := github.com/bennu/minikind

BIN:= minikind

OUTPUT := "./_output/bin/$(BIN)"

VERSION ?= master

GIT_SHA :=$$(git rev-parse HEAD)
GIT_DIRTY :=$$(git status --porcelain 2> /dev/null)

ifndef GIT_DIRTY
 GIT_TREE_STATE :=clean
else
 GIT_TREE_STATE := dirty
endif


GO_LDFLAGS :="
GO_LDFLAGS += -X $(PKG)/pkg/buildinfo.version=$(VERSION)
GO_LDFLAGS += -X $(PKG)/pkg/buildinfo.built=$(shell date +'%Y-%m-%dT%H:%M:%SZ')
GO_LDFLAGS += -X $(PKG)/pkg/buildinfo.gitSHA=$(GIT_SHA)
GO_LDFLAGS += -X $(PKG)/pkg/buildinfo.gitTreeState=$(GIT_TREE_STATE)
GO_LDFLAGS +="

GOFMT_FILES :=$$(find . -name '*.go' | grep -v vendor)
GOTEST_TARGETS?=$$(go list ./...)

build: fmt
	@echo "+ $@"
	CGO_ENABLED=0 GOOS=linux go build \
	-o $(OUTPUT) \
	-installsuffix cgo \
	-ldflags $(GO_LDFLAGS) \
    $(PKG)/cmd/$(BIN)

fmt:
	@echo "+ $@"
	gofmt -w $(GOFMT_FILES)

test: fmt
	@echo "+ $@"
	CGO_ENABLED=0 GOOS=linux go test \
	-installsuffix static \
	-ldflags $(GO_LDFLAGS) \
	$(GOTEST_TARGETS)

clean:
	@echo "+ $@"
	$(RM) $(OUTPUT)

.PHONY: build fmt test clean
