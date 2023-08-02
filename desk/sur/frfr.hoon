|%
::
+$  score
  $:  score=@rs 
      beer=[from=(unit @p) weight=@rs]
      alfie=(map @p [pos=@ud neg=@ud])
  ==
::
+$  frfr-action
  $%  [%compute =ship]
      [%add-edge =ship]
      [%del-edge =ship]
      [%placeholder ~]
  ==
--
