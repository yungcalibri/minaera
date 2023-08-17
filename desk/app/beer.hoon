/-  *beer, *minaera, service
/+  verb, dbug, default-agent, server, schooner, *sss, view=beer-view
|%
::
::  Basic reputation service
::
+$  versioned-state
  $%  state-0
  ==
::  Our state is a map from @p to beer.
::  Only the most recent beer is stored for each @p.
::
+$  state-0  [%0 bar=(map @p @)]
::
+$  card  card:agent:gall
::
++  minaera-init-card
|=  =ship
[%pass /minaera/action %agent [ship %minaera] %poke %aera-action !>([%init-table %beer %beer])]
::
++  eyre-bind-card
  :*  %pass  /eyre/connect  %arvo  %e
      %connect  [~ /apps/beer]  %beer
  ==
::
++  info-card
=/  desc=@t
'''
Scale ranging from 0 to 1 inclusive
  - 0 mean that I haven't met the person.
  - 1 means that I've met the person.
'''
:*  desc=desc
    type=%discrete
    aura=%ud
    min=0
    max=1
==
--
::
%+  verb  &
%-  agent:dbug
=/  pub-service  (mk-pubs service ,[%service *])
=|  state=state-0 ::
^-  agent:gall
::
=<
  |_  =bowl:gall
  +*  this  .
      hc  ~(. +> bowl)
      def  ~(. (default-agent this %|) bowl)
      du-service  =/  du  (du service ,[%service *])
                    (du pub-service bowl -:!>(*result:du))
  ++  on-fail
    ~>  %bout.[0 '%beer +on-fail']
    on-fail:def
  ::
  ++  on-leave
    ~>  %bout.[0 '%beer +on-leave']
    on-leave:def
  ::
  ++  on-arvo
    |=  [=wire sign=sign-arvo]
    ^-  (quip card _this)
    [~ this]
  ::
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%beer +on-init']
    :-  ~[(minaera-init-card our.bowl) eyre-bind-card]
    this
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%beer +on-save']
    !>([state pub-service])
  ::
  ++  on-load
    |=  =vase
    ~>  %bout.[0 '%beer +on-load']
    ^-  (quip card _this)
    =/  old  !<  [state-0 =_pub-service]  vase
    :-  ~
    %=    this
      state     -.old
      pub-service  pub-service.old
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ~>  %bout.[0 '%beer +on-poke']
    ^-  (quip card _this)
    ::  ~&  >>  "%beer: pub-service was: {<read:du-service>}"
    ?+    mark  !!
        %beer-action
      =/  act  !<(beer-action vase)
      =^  action-cards  state
        (handle-action:hc act)
      =^  service-cards  pub-service
        (give:du-service [%service %beer ~] act)
      [(weld action-cards service-cards) this]
      ::
        %sss-on-rock
      `this
      ::
        %sss-to-pub
      ?-   msg=!<(into:du-service (fled vase))
          [[%service *] *]
        =^  cards  pub-service  (apply:du-service msg)
        :: ~&  >>  "%beer: pub-service is: {<read:du-service>}"
        [cards this]
      ==
      ::
        %handle-http-request
      ?>  =(src.bowl our.bowl)
      =/  req  !<([eyre-id=@ta =inbound-request:eyre] vase)
      =*  dump
        :_  state
        (response:schooner eyre-id.req 404 ~ [%none ~])
      ?.  authenticated.inbound-request.req  dump
      ::  GET has no side effects, so we handle it separately.
      ?:  =(%'GET' method.request.inbound-request.req)
        =^  cards  state
          ~(get handle-http:hc req)
        [cards this]
      ::  These actions have side effects that must be dispatched to the
      ::  subscription service, so we have to get back the action they
      ::  performed.
      =/  next=[(quip card _state) beer-action]
        ?+    method.request.inbound-request.req  dump
        ::
            %'POST'
          ~(pot handle-http:hc req)
        ::
            %'DELETE'
          ~(del handle-http:hc req)
        ==
      =/  act  +.next
      =^  http-cards  state  -.next
      =^  service-cards  pub-service  (give:du-service [%service %beer ~] act)
      [(weld http-cards service-cards) this]
    ==
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 '%beer +on-peek']
    ^-  (unit (unit cage))
    ?+    path  `~
        [%x %score @ ~]
      =/  =ship  (slav %p -.+.+.path)
      ?.  (~(has by bar.state) ship)
        ``[%noun !>(~)]
      ``[%noun !>((~(get by bar.state) ship))]
    ::
        [%x %scores ~]
      ``[%noun !>(bar.state)]
    ::
        [%x %card ~]
      ``[%noun !>(info-card)]
    ==
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ~>  %bout.[0 '%beer +on-agent']
    ^-  (quip card _this)
    ?.  =(%poke-ack -.sign)
      ~&  >  beer+'bad poke'  `this
    ?+    wire  `this
        [~ %sss %scry-response @ @ @ %service *]
      =^  cards  pub-service  (tell:du-service |3:wire sign)
      ::  ~&  >  "%beer: pub-service is: {<read:du-service>}"
      [cards this]
    ==
  ::
  ++  on-watch
    |=  =path
    ~>  %bout.[0 '%beer +on-watch']
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%http-response *]
      [~ this]
    ==
  --
::
::  helper core
|_  =bowl:gall
::
++  handle-action
  |=  act=beer-action
  ^-  (quip card _state)
  =/  next-bar
    ?-    -.act
    ::
        %add
      (~(put by bar.state) ship.act `@`beer.act)
    ::
        %del
      (~(del by bar.state) ship.act)
    ==
  [~ state(bar next-bar)]
::
++  handle-http
  |_  [eyre-id=@ta =inbound-request:eyre]
  +*  req   (parse-request-line:server url.request.inbound-request)
      send  (cury response:schooner eyre-id)
      dump  [(send 404 ~ [%none ~]) state]
      derp  [(send 500 ~ [%stock ~]) state]
  ::
  ++  get-form-value
    |=  tgt=@t
    ^-  (unit @t)
    =/  body=(unit (list [key=@t value=@t]))
      ?~  body.request.inbound-request  ~
      (rush q.u.body.request.inbound-request yquy:de-purl:html)
    ?~  body  ~
    =/  vals=(list [key=@t value=@t])  u.body
    |-
    ?~  vals  ~
    ?:  =(key.i.vals tgt)
      [~ value.i.vals]
    $(vals t.vals)
  ::
  ++  whom-raw
    ^-  @t
    =/  got  (get-form-value 'whom')
    ?~  got  *@t
    u.got
  ::
  ++  whom
    ^-  (unit ship)
    =/  got  (get-form-value 'whom')
    ?~  got  ~
    (slaw %p u.got)
  ::
  ++  get
    ^-  (quip card _state)
    =/  site  site.req
    ?+    site  dump
    ::
        [%apps %beer %main ~]
      :_  state
      (send 200 ~ [%manx ~(main view state)])
    ==
  ::
  ++  pot
    ^-  [(quip card _state) beer-action]
    =/  whom  whom..
    =/  error
      ?:  =("" whom-raw)  ""
      ?~  whom  "{<whom-raw>} is not a valid @p"
      ?:  (~(has by bar.state) u.whom)
        "{<u.whom>} is already in your bar!"
      ""
    =/  site  site.req
    ?+    site  dump
    ::
        [%apps %beer %fake ~]
      ?~  whom  dump
      =/  act  `beer-action`[%add ship=u.whom %0]
      =/  next=(unit (quip card _state))
        %-  mole
        |.  (handle-action act)
      ?~  next  dump
      :_  act
      :_  +.u.next
      %+  weld
        -.u.next
      (send [303 ~ [%redirect '/apps/beer/main']])
    ::
        [%apps %beer %real ~]
      ?~  whom  dump
      =/  act  `beer-action`[%add ship=u.whom %1]
      =/  next=(unit (quip card _state))
        %-  mole
        |.  (handle-action act)
      ?~  next  dump
      :_  act
      :_  +.u.next
      %+  weld
        -.u.next
      (send [303 ~ [%redirect '/apps/beer/main']])
    ==
  ::
  ++  del
    ^-  [(quip card _state) beer-action]
    =/  whom  whom..
    ?~  whom  dump
    =/  site  site.req
    ?+    site  dump
    ::
        [%apps %beer %delete ~]
      =/  act  `beer-action`[%del ship=u.whom]
      =/  next=(unit (quip card _state))
        %-  mole
        |.  (handle-action act)
      ?~  next  dump
      :_  act
      :_  +.u.next
      %+  weld
        -.u.next
      (send [303 ~ [%redirect '/apps/beer/main']])
    ==
  ::
  --
::
--
