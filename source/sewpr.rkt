#lang racket
(provide sewpr.html)
(require SMathML)
(define $dot (Mo "&bull;"))
(define $Implies (Mo "&Implies;"))
(define $t:ms $t:monospace)
(define $f:ms $f:monospace)
(define (attach exp label)
  (Mrow exp "&nbsp;" (bra0 label)))
(define-infix*
  (&dot $dot)
  (&Implies $Implies)
  )
(define (@dot . x*)
  (@ (apply &dot x*)))
(define sewpr.html
  (TnTmPrelude
   #:title "语义工程和PLT Redex"
   #:css "styles.css"
   (H1 "语义工程和PLT Redex")
   (H2 "第1部分 规约语义")
   (H3 "第1章 语义via句法")
   (H4 "第1.1节 定义集合")
   (P "BNF语法可有多种用途. 一种含义是字符串的集合. 另一种解释是&quot;树&quot;"
      "的集合, 其常被称为抽象句法(树). 本书我们总是指后者.")
   (P "对于本章和下一章而言, 我们使用下面的BNF语法作为例子:"
      (MB ((Ttable (lambda (d i j)
                     (if (= j 2)
                         (set-attr* d 'columnalign "left")
                         d)))
           (deriv0 $B $= $t:monospace
                   $lv $f:monospace
                   $lv (@ (&dot $B $B)))))
      "我们将其当作下列施加于抽象句法树集合" $B "上的约束的缩写:"
      (MB (&Table
           ((&in $t:monospace $B))
           ((&in $f:monospace $B))
           ((&Implies (: (&in $a $B) "&nbsp;且&nbsp;" (&in $b $B))
                      (&in (@ (&dot $a $b)) $B)))))
      "从技术上说, " $B "是满足以上约束的最小集合. 为了构造这个集合, "
      "我们先容纳基本元素" $t:monospace "和" $f:monospace
      ", 然后归纳地将其中的东西组合成复合元素.")
   (P "记号: 我们有时用&quot;"$B"&quot;表示&quot;集合"$B"&quot;, 但有时&quot;"
      $B"&quot;也代表&quot;"$B"的任意一个元素&quot;. 从上下文来看, 含义总是明确的. "
      "有时, 我们将下标或一撇附加在集合的名字上来集合的任意元素, 例如&quot;"$B_1
      "&quot;或者&quot;"$B^"&quot;. 因此, 以上约束也可以写成"
      (MB
       (&Table
        ((&in $t:monospace $B) (bra0 "a"))
        ((&in $f:monospace $B) (bra0 "b"))
        ((&in (@ (&dot $B_1 $B_2)) $B) (bra0 "c")))))
   (P "在有限的空间之中枚举出" $B "的所有元素显然是不可能的:"
      (MB (&= $B
              (setE $t:monospace $f:monospace
                    (@ (&dot $t:monospace $t:monospace))
                    (@ (&dot $t:monospace $f:monospace))
                    $..h)))
      "然而, 给定某个树, 我们可以通过论证它满足约束来证明其属于" $B ". 例如, "
      (@dot $t:ms (@dot $f:ms $t:ms)) "就在" $B "中:"
      (MB (set-attr*
           (&Table
            ("1." (&in $t:ms $B) (: "by&nbsp;" (bra0 "a")))
            ("2." (&in $f:ms $B) (: "by&nbsp;" (bra0 "b")))
            ("3." (&in $t:ms $B) (: "by&nbsp;" (bra0 "a")))
            ("4." (&in (@dot $f:ms $t:ms) $B) (: "by 2, 3, and&nbsp;" (bra0 "c")))
            ("5." (&in (@dot $t:ms (@dot $f:ms $t:ms)) $B)
                  (: "by 1, 4, and&nbsp;" (bra0 "c"))))
           'columnalign "left"))
      "通常, 这样的论证也可以被安排成所谓的证明树的形式:"
      (MB (attach
           (&rule (attach (&in $t:ms $B) "a")
                  (attach
                   (&rule (attach (&in $f:ms $B) "b") (attach (&in $t:ms $B) "a")
                          (&in (@dot $f:ms $t:ms) $B))
                   "c")
                  (&in (@dot $t:ms (@dot $f:ms $t:ms)) $B))
           "c"))
      "绝大多数时候, 证明树以没有标签的形式出现, 因为每一步通常都是显然的:"
      (MB (&rule (&in $t:ms $B)
                 (&rule (&in $f:ms $B) (&in $t:ms $B)
                        (&in (@dot $f:ms $t:ms) $B))
                 (&in (@dot $t:ms (@dot $f:ms $t:ms)) $B))))
   (H4 "第1.2节 关系")
   (P "关系是序对的集合. "
      )
   (H4 "第1.3节 作为等价关系的语义")
   (H4 "第1.4节 语义via规约")
   (H4 "第1.5节 上下文中的规约")
   (H4 "第1.6节 求值函数")
   (H4 "第1.7节 记号总结")
   (H3 "第2章 分析句法性的语义")
   (H4 "第2.1节 从问题到数学声明")
   
   (H4 "第2.2节 作为定理的回答")
   
   (H3 "第3章 " $lambda "演算")

   (H3 "第4章 ISWIM")

   (H3 "第5章 抽象句法机器")

   (H3 "第6章 抽象寄存器机器")
   (H4 "第6.1节 CC机器")
   
   (H4 "第6.2节 SCC机器")
   
   (H4 "第6.3节 CK机器")
   
   (H4 "第6.4节 CEK机器")
   
   (H4 "第6.5节 历史")
   
   (H3 "第7章 尾调用和更多的空间节省")

   (H3 "第8章 控制: 错误, 异常和延续")

   (H3 "第9章 状态: 命令式赋值")

   (H3 "第10章 简单类型ISWIM")

   
   ))