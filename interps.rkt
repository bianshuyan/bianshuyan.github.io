#lang racket
(require "match.rkt" "env.rkt")
(define (interp0 exp env)
  (match exp
    (,x (guard (symbol? x)) (apply-env env x))
    ((lambda (,x) ,body) (lambda (arg)
                           (interp0 body (extend-env x arg env))))
    ((,rator ,rand) ((interp0 rator env) (interp0 rand env)))))
(define (interp1 exp env)
  (match exp
    (,x (guard (symbol? x)) (apply-env env x))
    ((lambda (,x) ,body) (make-closure x body env))
    ((,rator ,rand) (apply-closure (interp1 rator env)
                                   (interp1 rand env)))))
(define (make-closure var body env)
  (list 'closure var body env))
(define (apply-closure closure arg)
  (match closure
    ((closure ,var ,body ,env)
     (interp1 body (extend-env var arg env)))))
(define (interp2 exp env)
  (match exp
    (,x (guard (symbol? x)) (apply-env env x))
    ((lambda (,x) ,body) (lambda (arg env)
                           (interp2 body (extend-env x arg env))))
    ((,rator ,rand) ((interp2 rator env) (interp2 rand env) env))))
(define (interp3 exp env k)
  (match exp
    (,x (guard (symbol? x)) (k (apply-env env x)))
    ((lambda (,x) ,body) (k (lambda (arg k)
                              (interp3 body (extend-env x arg env) k))))
    ((,rator ,rand) (interp3 rator env
                            (lambda (fun)
                              (interp3 rand env
                                      (lambda (arg)
                                        (fun arg k))))))))