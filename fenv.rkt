#lang racket
(provide (all-defined-out))
(define (empty-env)
  (lambda (var)
    (error 'empty-env "unbound variable ~s" var)))
(define (extend-env var val env)
  (lambda (var0)
    (if (eq? var var0)
        val
        (apply-env env var0))))
(define (ext-env var val env)
  (lambda (var0)
    (if (eq? var var0)
        val
        (app-env env var0))))
(define (apply-env env var) (env var))
(define (app-env env var) (env var))
(define (lookup var env) (env var))