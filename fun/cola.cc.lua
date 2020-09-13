{{/*
	This command allows you to send a cola through YAGPDB.
	You may send it as embed using `-cola [target]`.

	Recommended trigger: Command trigger with trigger '-cola'
*/}}

{{ $channel := .Channel }}
{{ $msg := "I'll give you a cola." }}
{{ $target := joinStr " " .CmdArgs }}

{{ if $target }}
	{{ sendMessage $channel.ID (cembed
		"author" (sdict "name" "Chika Fujiwara" "url" "https://imgur.com/TQrsoR2")
		"description" (joinStr "" $target ", " $msg)
		"color" 16764159
    "image" (sdict "url" "https://cdn.discordapp.com/attachments/753012187676541078/754117477633490945/Chika_Cola.jpg")
	) }}
{{ else }}
	Sorry, you didn't provide a target!
{{ end }}
