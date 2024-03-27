#lang racket
(provide index.html)
(require SMathML)
(define index.html
  (Prelude
   #:title "混沌空间"
   #:css "styles.css"
   (H1 "混沌空间")
   (columnize
    (H2 (A "操作语义的结构方法" #:attr* '((href "sos.html"))))
    (H2 (A "指称语义学" #:attr* '((href "ds.html"))))
    (H2 (A "灵活软件设计" #:attr* '((href "sdf.html"))))
    (H2 (A "证明与类型" #:attr* '((href "prot.html"))))
    (H2 (A "语义工程和PLT Redex" #:attr* '((href "sewpr.html"))))
    (H2 (A "古典力学的结构和解释" #:attr* '((href "sicm.html"))))
    (H2 (A "构建问题解决器" #:attr* '((href "bps.html"))))
    (H2 (A "函数式微分几何" #:attr* '((href "fdg.html"))))
    (H2 (A "乌龟几何" #:attr* '((href "tg.html"))))
    (H2 (A "数据结构和算法" #:attr* '((href "dsaa.html"))))
    (H2 (A "句法闭包" #:attr* '((href "synclo.html"))))
    (H2 (A "Topos: 逻辑的范畴分析" #:attr* '((href "topos.html"))))
    (H2 (A "Scheme的三种实现模型" #:attr* '((href "timp.html"))))
    (H2 (A "归纳定义" #:attr* '((href "induc.html"))))
    (H2 (A "元对象协议艺术" #:attr* '((href "mop.html"))))
    (H2 (A "无穷级数的理论和应用" #:attr* '((href "series.html"))))
    (H2 (A "Abel定理" #:attr* '((href "abel.html"))))
    (H2 (A "微积分 (Apostol)" #:attr* '((href "calculus.html"))))
    (H2 (A "Standard ML的历史" #:attr* '((href "sml-history.html"))))
    (H2 (A "卫生宏技术" #:attr* '((href "macro.html"))))
    (H2 (A "胡言乱语" #:attr* '((href "huyan.html"))))
    (H2 (A "数学家学法语" #:attr* '((href "french.html"))))
    (H2 (A "理解Maxima" #:attr* '((href "maxima.html"))))
    (H2 (A "把东西粘在一起" #:attr* '((href "scheme_cg.html"))))
    
    )
   ))