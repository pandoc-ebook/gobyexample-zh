COVER ?= R
DEVICE ?= pc
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=思源黑体,ItalicFont=KaiTi
SUBTITLE ?= -M subtitle:
HIGHLIGHT ?= --highlight-style=tango

OWNER ?= pandoc-ebook
REPO ?= gobyexample-zh
TAG ?= $(shell git describe HEAD --tags --exact-match 2>/dev/null || echo "latest")

all: zhelegant enelegant bothelegant clean
zhelegant:
	panbook book --style=elegantbook -V device:$(DEVICE) $(HIGHLIGHT)
	mv build/gobyexample-zh-book-elegantbook-pc.pdf build/gobyexample-zh-$(TAG).pdf
enelegant:
	panbook book --style=elegantbook -V device:$(DEVICE) -G ext-zh_en-lang:en -V lang:en $(SUBTITLE) $(HIGHLIGHT)
	mv build/gobyexample-zh-book-elegantbook-pc.pdf build/gobyexample-zh-en-$(TAG).pdf
bothelegant:
	panbook book --style=elegantbook -V device:$(DEVICE) -G ext-zh_en-lang:both $(HIGHLIGHT)
	mv build/gobyexample-zh-book-elegantbook-pc.pdf build/gobyexample-zh-zh_en-$(TAG).pdf

up: release upload
release:
	git tag -a $(TAG) -m "$(TAG)"
	git push origin $(TAG)
	curl -H "Content-Type:application/json" -H "Authorization: token $$GITHUB_TOKEN" -XPOST "https://api.github.com/repos/$(OWNER)/$(REPO)/releases" -d '{"tag_name":"$(TAG)"}'
upload:
	ID=`curl -s -H "Authorization: token $$GITHUB_TOKEN" "https://api.github.com/repos/$(OWNER)/$(REPO)/releases/tags/$(TAG)" |grep '"id"' |head -n 1 |awk '{print $$2}' |tr -d ','`; echo "ID: $$ID";\
	cd build/; \
	for FILE in `ls $(REPO)-*.pdf`;do \
		echo $$FILE;\
		curl -H "Authorization: token $$GITHUB_TOKEN" -H "Content-Type: $$(file -b --mime-type $$FILE)" "https://uploads.github.com/repos/$(OWNER)/$(REPO)/releases/$$ID/assets?name=$$(basename $$FILE)" --data-binary @$$FILE; echo; \
	done

clean:
	panbook clean