/-  *beer
/+  sigil
|_  [%0 bar=(map @p @)]
::
++  reals
  ^-  (list [@p @])
  (skim ~(tap by bar) |=([* val=@] =(1 val)))
::
++  fakes
  ^-  (list [@p @])
  (skim ~(tap by bar) |=([* val=@] =(0 val)))
::
++  toast
  |=  [whom=@p val=@]
  ^-  manx
  ;div.toast
    ;+  %.  whom
        %_  sigil
          size    48
          fg      "var(--sigil-color)"
          bg      "var(--background-color)"
          margin  |
          icon    |
        ==
    ;form
      =name  "toggle"
      ;input(name "whom", type "hidden", value "{<whom>}");
      ;button
        =hx-post    ?:(=(0 val) "/apps/beer/1" "/apps/beer/0")
        ::  redirects to main when successful
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ; Toggle
      ==
      ;button
        =hx-delete  "/apps/beer/delete"
        ::  redirects to main when successful
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ; Delete
      ==
    ==
  ==
::
++  main
  ^-  manx
  ;div#beer
    ;h2: The [Beer] Bar
    ;div.add
      ;form
        =name       "add-beer"
        =hx-swap    "outerHTML"
        =hx-target  "#beer"
        ;button
          =hx-post  "/apps/beer/1"
          ; Real!
        ==
        ;input
          =name         "whom"
          =placeholder  "~sumwon-sumwer"
          =hx-post      "/apps/beer/validate"
          =hx-target    "next .error"
          =hx-swap      "innerHTML"
          =hx-trigger   "change, keyup delay:200ms"
          =required     "";
        ;button
          =hx-post  "/apps/beer/0"
          ; Fake!
        ==
      ==
    ==
    ;center-l(intrinsic "")
      ;div.error:""
    ==
    ;div.bar
      ;div.reals
        ;*  (turn reals toast)
      ==
      ;div.fakes
        ;*  (turn fakes toast)
      ==
    ==
  ==
::
--
