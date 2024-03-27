#lang racket
(provide timp.html)
(require SMathML)
(define (&label x . t*)
  (Table #:attr* '((align "center"))
         (Tr (Td #:attr* '((align "center")) x))
         (Tr (keyword-apply
              Td '(#:attr*) '(((align "center")))
              t*))))
(define body-id
  (Mi "body" #:attr* '((mathvariant "italic"))))
(define (idlize x)
  (Mi x #:attr* '((mathvariant "italic"))))
(define var-id (idlize "var"))
(define val-id (idlize "val"))
(define exp-id (idlize "exp"))
(define init-id (idlize "init"))
(define x-id (idlize "x"))
(define obj-id (idlize "obj"))
(define vars-id (idlize "vars"))
(define timp.html
  (TnTmPrelude
   #:title "Scheme的三种实现模型"
   #:css "styles.css"
   (H1 "Scheme的三种实现模型")
   (P "注记: 本文是1987年写成的, 所以其中的Scheme语言与现在相比或多或少有些区别. "
      "例如, 空表也被视为假, 而不是R5RS及之后的真.")
   (H2 "第1章 引论")
   (H3 "第1.1节 函数式编程语言")
   (H3 "第1.2节 函数式编程语言实现")
   (H3 "第1.3节 多处理器系统和实现")
   (H2 "第2章 Scheme语言")
   (H3 "第2.1节 句法形式和原始函数")
   (H4 "第2.1.1小节 核心句法形式")
   (P (CodeB "&lt;core> -> &lt;object>
&lt;core> -> &lt;variable>
&lt;core> -> (quote &lt;object>)
&lt;core> -> (lambda (&lt;variable> ...) &lt;core>)
&lt;core> -> (if &lt;core> &lt;core> &lt;core>)
&lt;core> -> (set! &lt;variable> &lt;core>)
&lt;core> -> (call/cc &lt;core>)
&lt;core> -> (&lt;core> &lt;core> ...)")
      "图2.1 Scheme核心语言的句法")
   (H4 "第2.1.2小节 原始函数")
   
   (H4 "第2.1.3小节 句法扩展")
   (CodeB "(let (["var-id" "val-id"] ...) "exp-id " ...) "$->"
((lambda ("var-id " ...) "exp-id" ...) "val-id" ...)")
   (CodeB "(rec "var-id" "exp-id") "$->"
(let (["var-id" '()])
  (set! "var-id" "exp-id"))")
   (P "注记: 从时代背景来说, 当时已有R"(Sup "2")"RS, 其中" (Code "rec")
      "作为特殊形式出现. 另外, " (Code "(set! "var-id" "exp-id")")
      "的返回值在所有Scheme标准中都是unspecified, 但是这里的实现的决定是"
      "返回RHS的值, 目前Kent Dybvig的Chez Scheme的决定是返回" (Code "(void)")
      "的值.")
   (CodeB "(recur f (["var-id" "init-id" ...) "exp-id" ...) "$->"
((rec f (lambda ("var-id" ...) "exp-id" ...)) "init-id" ...)")
   (P "注记: " (Code "recur") "其实就相当于named let.")
   (CodeB "(and "(_ exp-id $1)") "$->" "(_ exp-id $1)"
(and "(_ exp-id $1)" "(_ exp-id $2)" ...) "$->"
(if "(_ exp-id $1)" (and "(_ exp-id $2)" ...) '())")
   (CodeB "(or "(_ exp-id $1)") "$->" "(_ exp-id $1)"
(or "(_ exp-id $1)" "(_ exp-id $2)" ...) "$->"
(if "(_ exp-id $1)" 't (or "(_ exp-id $2)" ...))")
   (P "注记: 实际上这里不论" (Code "and") "还是" (Code "or")
      "都与现代Scheme稍有不同. 一个是现在" (Code "(and)")
      "和" (Code "(or)") "也有定义, 另外就是对于"
      (Code "(or "(_ exp-id $1)" "(_ exp-id $2)" ...)")
      "而言, 如果" (Code (_ exp-id $1)) "为真, 那么应该返回"
      (Code (_ exp-id $1)) "的值. 当然, 读者应该还看出了一点不同, "
      "就是当时的Scheme用" (Code "'t") "来表示真, 而不是特殊的布尔类型, "
      "这与其他许多Lisp方言是类似的.")
   (CodeB "(record ("var-id" ...) "val-id" "exp-id" ...) "$->"
(apply (lambda ("var-id" ...) "exp-id" ...) "val-id")")
   (H3 "第2.2节 闭包")
   (H3 "第2.3节 赋值")
   (H3 "第2.4节 延续")
   (H3 "第2.5节 一个元循环解释器")
   (P "本节呈现了一个Scheme的元循环解释器. 一个Scheme元循环解释器是用Scheme写成的"
      "Scheme解释器. 运行解释器的Scheme系统相对于由解释器实现的Scheme系统而言位于"
      "元层次. 显然, 元循环解释器中可以再运行一个解释器, 那么原本的元层次就变成了"
      "元元层次. 从理论上来说, 这个过程可以无限地 (indefinitely) 被执行下去, "
      "提供一个解释器的无穷之塔 [Smi82].")
   (P ""
      )
   (CodeB "(define meta
  (lambda (exp)
    (exec exp '())))")
   (CodeB "(define exec
  (lambda (exp env)
    (cond
      [(symbol? exp) (car (lookup exp env))]
      [(pair? exp)
       (record-case exp
         [quote (obj) obj]
         [lambda (vars body)
          (lambda (vals)
            (exec body (extend env vars vals)))]
         [if (test then else)
          (if (exec test env)
              (exec then env)
              (exec else env))]
         [set! (var val)
          (set-car! (lookup var env) (exec val env))]
         [call/cc (exp)
          (call/cc
            (lambda (k)
              ((exec exp env)
               (list (lambda (args) (k (car args)))))))]
         [else
          ((exec (car exp) env)
           (map (lambda (x) (exec x env)) (cdr exp)))])]
      [else exp])))")
   (P "注记: 以上的解释器主体原本多出一行"
      (Code "[call/cc (exp) (call/cc (exec exp env))]")
      ", 实际上并不发挥任何作用, 而且是错误的. 愚猜测是Kent Dybvig"
      "最初采取了错误的写法, 之后又纠正过来, 但是忘了把原本的错误删掉 "
      "(抑或是有意保留错误给读者看).")
   (CodeB "(define lookup
  (lambda (var e)
    (let nxtrib ([e e])
      (let nxtelt ([vars (caar e)] [vals (cdar e)])
        (cond
          [(null? vars) (nxtrib (cdr e))]
          [(eq? (car vars) var) vals]
          [else (nxtelt (cdr vars) (cdr vals))])))))")
   (P "注记: 愚将以上的两个" (Code "recur") "改成了" (Code "let")
      ", 因为虽然它们是等价的, 但几乎没有Scheme实现提供"
      (Code "recur") ", 即便是Kent Dybvig本人的Chez Scheme.")
   (CodeB "(define extend
  (lambda (env vars vals)
    (cons (cons vars vals) env)))")
   (H2 "第3章 基于堆的模型")
   (H3 "第3.1节 动机和问题")
   (H3 "第3.2节 数据结构的表示")
   (H4 "第3.2.1小节 环境")
   (P "环境是由序对构成的, 其结构就像肋骨笼. 一个环境是一个列表, 其每个元素都是"
      "列表的序对. 这个序对由变量的肋骨和相应的值的肋骨构成. 让我们考虑一个简单的例子:"
      (CodeB "((lambda (a b)
   ((lambda (c)
      ((lambda (d e f) " body-id ") 3 4 5))
    2))
 0 1)")
      "假设环境为空, 对于" (Code body-id) "求值时, 环境的结构为:"
      (CodeB "(((d e f) . (3 4 5))
 ((c) . (2))
 ((a b) . (0 1)))"))
   (P "环境的实现见第2.5节.")
   (H4 "第3.2.2小节 帧与控制栈")
   (P ""
      )
   (H3 "第3.3节 实现策略")
   (H3 "第3.4节 实现基于堆的模型")
   (H4 "第3.4.1小节 汇编代码")
   (P (Code "(halt)") "停下虚拟机器, 而累积器之中的值就是计算的结果.")
   (P (Code "(refer "var-id" "x-id")") "找出变量" (Code var-id)
      "在当前环境中的值, 将其置于累积器之中, 将下一个表达式置为" (Code x-id) ".")
   (P (Code "(constant "obj-id" "x-id")") "将" (Code obj-id)
      "置于累积器之中, 将下一个表达式置为" (Code x-id) ".")
   (P (Code "(close "vars-id" "body-id" "x-id")") "根据" (Code body-id)
      ", " (Code vars-id) "和当前环境创建闭包, 将其置于累积器之中, 并"
      "将下一个表达式置为" (Code x-id) ".")
   (P ""
      )
   (H3 "第3.5节 改进变量访问")
   (H2 "第4章 基于栈的模型")
   (H2 "第5章 基于字符串的模型")
   (H2 "第6章 结论")
   ))