#lang racket
(provide ds.html)
(require SMathML)
(define $. (Mo "." #:attr* '((lspace "0") (rspace "0"))))
(define pre:ds.html
  (TnTmPrelude
   #:title "指称语义学"
   #:css "styles0.css"
   (H1 "指称语义学")
   (H2 "第1章 引论")
   (H2 "第2章 指称语义学")
   (H2 "第3章 二进制数码")
   (H2 "第4章 第一级函数")
   (H2 "第5章 " $lambda "演算")
   (H3 "第5.1节 " $lambda "演算")
   
   (H3 "第5.2节 递归定义")
   
   (H2 "第6章 格与域")
   (P "前一章最后的讨论已经指出如果我们想要成功地找到一个" $lambda "演算的语义理论, 那么"
      "我们就必须找出一种限制我们能够考虑的函数类的方法. "
      )
   (H3 "第6.1节 近似序")
   (P "考虑递归函数:"
      (MB ((Ttable (lambda (d i j)
                     (if (= j 1)
                         (set-attr* d 'columnalign "left")
                         d)))
           (&Table
            ((: $f $= $lambda $x $.)
             (: "if&nbsp;"
                (&= $x $0)
                "&nbsp;then&nbsp;"
                $1))
            ($ (: "else if&nbsp;"
                  (&= $x $1)
                  "&nbsp;then&nbsp;"
                  (app $f $3)))
            ($ (: "else&nbsp;" (app $f (&- $x $2)) ".")))))
      
      )
   (H3 "第6.2节 偏序集")
   (H3 "第6.3节 完全格")
   (H3 "第6.4节 格上的函数")
   (H3 "第6.5节 一个不动点算子")
   (H2 "第7章 自反域")
   (H2 "第8章 " $lambda "演算的形式语义")
   
   ))
(define Tds
  (T `((mtext
        *preorder*
        ,(lambda (tag attr* . xml*)
                 `(mtext ,(attr*-set attr* 'mathvariant "monospace")
                         . ,xml*))))))
(define ds.html
  (Tds pre:ds.html))