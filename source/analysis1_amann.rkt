#lang racket
(provide analysis1_amann.html)
(require SMathML)
(define analysis1_amann.html
  (TmPrelude
   #:title "分析一 (Amann & Escher)"
   #:css "styles.css"
   (H1 "分析一 (Amann & Escher)")
   (H2 "第一章 基础")
   
   (H2 "第二章 收敛")
   
   (H2 "第三章 连续函数")
   
   (H2 "第四章 单变元微分")
   (P "第二章里我们探索了极限的概念, 这是分析里最基础也最本质性的想法之一. 我们建立了计算极限的方法, "
      "并呈现了其许多重要的应用. 在第三章中, 我们仔细考察了分析的拓扑基础和连续性的概念. "
      )
   (H3 "第4.1节 可微性")
   
   (H2 "第五章 函数序列")
   
   ))