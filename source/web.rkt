#lang racket
(require SMathML
         "styles.rkt"
         "styles0.rkt"
         "index.rkt"
         "sos.rkt"
         "prot.rkt"
         "fdg.rkt"
         "sewpr.rkt"
         "dsaa.rkt"
         "timp.rkt"
         "induc.rkt"
         "ds.rkt"
         "tg.rkt"
         "sdf.rkt"
         "sicm.rkt"
         "bps.rkt"
         "synclo.rkt"
         "topos.rkt"
         "mop.rkt"
         "series.rkt"
         "abel.rkt"
         "calculus.rkt"
         "sml-history.rkt"
         "macro.rkt"
         "huyan.rkt"
         "french.rkt"
         "maxima.rkt"
         "scheme_cg.rkt"
         
         )
(define (emit-web)
  (emitCss styles.css "../styles.css")
  (emitCss styles0.css "../styles0.css")
  (emitXml index.html "../index.html")
  (emitXml sos.html "../sos.html")
  (emitXml prot.html "../prot.html")
  (emitXml fdg.html "../fdg.html")
  (emitXml sewpr.html "../sewpr.html")
  (emitXml dsaa.html "../dsaa.html")
  (emitXml timp.html "../timp.html")
  (emitXml induc.html "../induc.html")
  (emitXml ds.html "../ds.html")
  (emitXml tg.html "../tg.html")
  (emitXml sdf.html "../sdf.html")
  (emitXml sicm.html "../sicm.html")
  (emitXml bps.html "../bps.html")
  (emitXml synclo.html "../synclo.html")
  (emitXml topos.html "../topos.html")
  (emitXml mop.html "../mop.html")
  (emitXml series.html "../series.html")
  (emitXml abel.html "../abel.html")
  (emitXml calculus.html "../calculus.html")
  (emitXml sml-history.html "../sml-history.html")
  (emitXml macro.html "../macro.html")
  (emitXml huyan.html "../huyan.html")
  (emitXml french.html "../french.html")
  (emitXml maxima.html "../maxima.html")
  (emitXml scheme_cg.html "../scheme_cg.html")
  
  )
(emit-web)