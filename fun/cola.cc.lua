{{/*
	This command allows you to send a cola through YAGPDB.
	You may send it as embed using `-send [channel] <content>` or as raw with `-send-raw [channel] <content>`.

	Recommended trigger: Command trigger with trigger '-cola'
*/}}

{{ $type := or (reFind `raw` .Cmd) "" }}
{{ $channel := .Channel }}
{{ $msg := "I'll give you a cola." }}
{{ if .CmdArgs }}
	{{ $channelID := "" }}
	{{ with reFindAllSubmatches `<#(\d+)>` (index .CmdArgs 0) }} {{ $channelID = index . 0 1 }} {{ end }}
	{{ $temp := getChannel (or $channelID (index .CmdArgs 0)) }}
	{{ if $temp }}
		{{ $channel = $temp }}
		{{ $msg = slice .CmdArgs 1 | joinStr " " }}
	{{ end }}
{{ end }}
{{ if $msg }}
	{{ if eq $type "raw" }}
		{{ sendMessageNoEscape $channel.ID $msg }}
	{{ else }}
		{{ sendMessage $channel.ID (cembed
			"author" (sdict "name" .User.String "icon_url" (.User.AvatarURL "256"))
			"description" $msg
			"color" 14232643
			"footer" (sdict "text" (printf "Message sent from #%s" .Channel.Name))
			"timestamp" currentTime
      "image" (sdict "url" "https://cdn.discordapp.com/attachments/753012187676541078/754117477633490945/Chika_Cola.jpg")
		) }}
	{{ end }}
	{{ if ne $channel.ID .Channel.ID }}
		Successfully sent message to <#{{ $channel.ID }}>!
	{{ end }}
{{ else }}
	Sorry, you didn't provide anything to say!
{{ end }}
