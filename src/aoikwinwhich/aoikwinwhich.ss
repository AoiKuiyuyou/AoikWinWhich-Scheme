;
#lang scheme

;
(define (string-endswith str end)
  (let ([str_len ; be
    (string-length str)
    ]
    [end_len ; be
    (string-length end)
    ])
    ; then
    (if (< str_len end_len)
      ; then
      #f
      ; else
      (equal? end (substring str (- str_len end_len)))
    )
  )
)

;
(define (find_exe_paths prog)
  ; 8f1kRCu
  (let ([env_pathext (getenv "PATHEXT")])
  ; in

    ; 4fpQ2RB
    (if (not env_pathext)
      ; then
      ; 9dqlPRg
      ; Return
      '()
      ; else
      ; 6qhHTHF
      ; Split into a list of extensions
      (let ([ext_s
        ; be
        (string-split env_pathext ";")
        ])
        ; in

        ; 2pGJrMW
        ; Strip
        (let ([ext_s
          ; be
          (for/list ([ext ext_s]) (string-trim ext))
          ])
          ; in

          ; 2gqeHHl
          ; Remove empty.
          ; Must be done after the stripping at 2pGJrMW.
          (let ([ext_s
            ; be
            (filter (lambda (x) (not (equal? x ""))) ext_s)
            ])
            ; in

            ; 2zdGM8W
            ; Convert to lowercase
            (let ([ext_s
              ; be
              (for/list ([ext ext_s]) (string-downcase ext))
              ])
              ; in

              ; 2fT8aRB
              ; Uniquify
              (let ([ext_s
                ; be
                (remove-duplicates ext_s)
                ])
                ; in

                ; 4ysaQVN
                (let ([env_path
                  ; be
                  (getenv "PATH")])
                  ; in

                  ;
                  (let ([dir_path_s
                    ; be
                    ; 5gGwKZL
                    (if (not env_path)
                      ; then
                      '()
                      ; else
                      ; 6mPI0lg
                      ; Split into a list of extensions
                      (string-split env_path ";")
                    )
                    ])
                    ; in
                    ; 5rT49zI
                    ; Insert empty dir path to the beginning.
                    ;
                    ; Empty dir handles the case that "prog" is a path,
                    ; either relative or absolute. See code 7rO7NIN.
                    (let ([dir_path_s
                      ; be
                      (cons "" dir_path_s)
                      ])
                      ; in

                      ; 2klTv20
                      ; Uniquify
                      (let ([dir_path_s
                        ; be
                        (remove-duplicates dir_path_s)
                        ])
                        ; in

                        ; 9gTU1rI
                        ; Check if "prog" ends with one of the file
                        ; extension in "ext_s".
                        ;
                        ; "ext_s" are all in lowercase, ensured at 2zdGM8W.
                        (let ([prog_lc
                          ; be
                          (string-downcase prog)
                          ])
                          ; in
                          (let ([prog_has_ext
                            ; be
                            (findf (lambda (ext) (string-endswith prog_lc ext))
                              ext_s)
                            ])
                            ; in

                            ; 6bFwhbv
                            (let ([exe_path_s
                              ; be
                              '()
                              ])
                              ; in
                              (begin
                                (for ([dir_path dir_path_s])
                                  ; 7rO7NIN
                                  ; Synthesize a path
                                  (let ([path ; be
                                    (if (equal? dir_path "")
                                        ; then
                                        prog
                                        ;else
                                        (string-join
                                          (list dir_path "\\" prog) ""
                                        )
                                    )
                                    ])
                                    ; in
                                    (begin
                                      ; 6kZa5cq
                                      ; If "prog" ends with executable file
                                      ; extension
                                      (if prog_has_ext
                                          ; then
                                          ; 3whKebE
                                          (if (file-exists? path)
                                            ; then
                                            ; 2ffmxRF
                                            ; Use "cons" so remember to
                                            ; reverse at 2qScrZs
                                            (set! exe_path_s
                                              (cons path exe_path_s)
                                            )
                                            ; else
                                            #f
                                            )
                                          ; else
                                          #f
                                          )

                                      ; 2sJhhEV
                                      ; Assume user has omitted the file
                                      ; extension
                                      (for ([ext ext_s])
                                        ; 6k9X6GP
                                        ; Synthesize a path with one of the
                                        ; file extensions in PATHEXT
                                        (let ([path
                                          ; be
                                          (string-append path ext)
                                          ])
                                          ; in

                                          ; 6kabzQg
                                          (if (file-exists? path)
                                              ; then
                                              ; 7dui4cD
                                              (set! exe_path_s (cons path exe_path_s))
                                              ; Use "cons" so remember to
                                              ; reverse at 2qScrZs

                                              ; else
                                              #f
                                              )
                                          )
                                        )
                                      )
                                    )
                                  )

                                ; Reverse due to "cons" at 2ffmxRF and
                                ; 7dui4cD
                                (let ([exe_path_s
                                  ; be
                                  (reverse exe_path_s)
                                  ])
                                  ; in

                                  ; 8swW6Av
                                  ; Uniquify
                                  (let ([exe_path_s
                                    ; be
                                    (remove-duplicates exe_path_s)
                                    ])
                                    ; in

                                    ; 2qScrZs
                                    ; Return
                                    exe_path_s
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)

;
(define (main)
  ;
  (let ([cmd_len ; be
         (vector-length (current-command-line-arguments))
         ])

    ; 9mlJlKg
    ; If not exactly one command argument is given
    (if (not (equal? cmd_len 1))
        ; then
        (begin
          ; 7rOUXFo
          ; Print program usage
          (printf "Usage: aoikwinwhich PROG

#/ PROG can be either name or path
aoikwinwhich notepad.exe
aoikwinwhich C:\\Windows\\notepad.exe

#/ PROG can be either absolute or relative
aoikwinwhich C:\\Windows\\notepad.exe
aoikwinwhich Windows\\notepad.exe

#/ PROG can be either with or without extension
aoikwinwhich notepad.exe
aoikwinwhich notepad
aoikwinwhich C:\\Windows\\notepad.exe
aoikwinwhich C:\\Windows\\notepad
")

          ; 3nqHnP7
          ; Exit
          1
          )
        ; else
        ; 9m5B08H
        ; Get executable name or path
        (let ([prog ; be
               (vector-ref (current-command-line-arguments) 0)
               ])
          ; then
          ; 8ulvPXM
          ; Find executable paths
          (let ([exe_path_s ; be
                 (find_exe_paths prog)
                 ])
            ; 5fWrcaF
            ; Has found none
            (if (empty? exe_path_s)
                ; then
                ; 3uswpx0
                ; Exit
                2
                ; else
                (begin
                  ; 9xPCWuS
                  ; Print result
                  (printf (string-append (string-join exe_path_s "\n") "\n"))

                  ; 4s1yY1b
                  ; Exit
                  0
                  )
                )
            )
          )
        )
    )
  )

; 4zKrqsC
; Program entry
(exit (main))
