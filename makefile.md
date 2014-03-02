Makefile
========

Makefiles are essentially macros for shell commands.

If the following was in your Makefile:

```bash
test:
	@phpunit
	@karma
```

running `make test` would run phpunit, then karma.

## Targets

You can make a target require others - for example in a Laravel project:

```bash
install: clean composer
	@php artisan migrate
	@grunt

clean:
	rm -rf vendor
	rm -rf public/_js

composer:
	@composer install
```

Running `make install` would run the clean target, then the composer target, before running migrate and grunt.

## @

In the example above, you may notice that some lines have an `@` before them, and some do not. If they do not start with an `@`, then the command will not be output to STDOUT. If they do, it will. Anything the commands output themselves will still be output as normal - it's just the command.

So, running `make clean` would output

```bash
rm -rf vendor
rm -rf public/_js
```

but running `make composer` would just output `composer install`'s normal output.

## Variables

You can use variables in Makefiles. Default values are typically declared at the top of the Makefile

```bash
output_dir = output

output:
	mkdir -p $(output_dir)
```

Running `make output` will create a directory - `output`

Running `make output output_dir=other/directory` will create the directory `directory`, inside `other`.

## PHP

Here is a sample PHP makefile

```bash
install: clean
	@composer install

test:
	@phpunit

clean-test:
	@rm -rf report

coverage:
	@phpunit --coverage-html ./report

report: coverage
	@open ./report/index.html

clean: clean-test
	@rm -rf vendor
	@rm -f composer.lock

todo:
	@echo "@TODO"
	@echo "====="
	@grep -rn "@TODO" . | awk -F ":" '$$1 != "./Makefile" {print $$3; print $$1 $$2  }'
	@echo
	@echo "@todo"
	@echo "====="
	@grep -rn "@todo" . | awk -F ":" '$$1 != "./Makefile" {print $$3; print $$1 $$2  }'
```
