{{/*
    This command allows you to send a cola through YAGPDB.
    You may send it as embed using `-cola [target]`.

    Recommended trigger: Command trigger with trigger '-cola'
*/}}

{{ $color := 16764159}}
{{ $msg := "I'll give you a cola." }}
{{ $image := "https://cdn.discordapp.com/attachments/753012187676541078/754117477633490945/Chika_Cola.jpg"}}
{{ $name := "Chika Fujiwara" }}

{{/* DONT CHANGE ANYTHING PAST THIS */}}

{{ $channel := .Channel }}
{{ $target := joinStr " " .CmdArgs }}

{{ if $target }}
    {{ sendMessage $channel.ID (cembed
        "author" (sdict "name" $name "url" "https://imgur.com/TQrsoR2")
        "description" (joinStr "" $target ", " $msg)
        "color" $color
    "image" (sdict "url" $image)
    ) }}
{{ else }}
    Sorry, you didn't provide a target!
{{ end }}
