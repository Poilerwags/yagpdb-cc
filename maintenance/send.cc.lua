{{/*
    This command allows you to send messages through YAGPDB, with optional channel.
    You may send it as embed using `-send [channel] <content>` or as raw with `-send-raw [channel] <content> [color]`.

    Recommended trigger: Regex trigger with trigger `^-(send-?(raw)?)`
*/}}

{{$multipliers := cslice 1048576 65536 4096 256 16 1}}
{{$hex2dec := sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15 "a" 10 "b" 11 "c" 12 "d" 13 "e" 14 "f" 15}}

{{ $hex := 0}}
{{ $dec := 0}}

{{ if eq (len .CmdArgs) 2}}
	{{$p := 0}}{{$r := .Member.Roles}}{{range .Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $p .Position)}}{{$p = .Position}}{{$dec = .Color}}{{end}}{{end}}
{{ end }}

{{ if eq (len .CmdArgs) 3}}
  {{ $hex = (index .CmdArgs 2)}}
  {{ $hex = index (split $hex "#") 1}}
  {{ range $k, $v := split $hex ""}}
  {{ $multiplier := index $multipliers $k}}
  {{ $num := or ($hex2dec.Get $v) $v }}
	{{ $dec = add $dec (mult $num $multiplier)}}
{{ end }}
{{ end }}

{{ $type := or (reFind `raw` .Cmd) "" }}
{{ $channel := .Channel }}
{{ $msg := joinStr " " (index .CmdArgs 1)}}
{{ if .CmdArgs }}
    {{ $channelID := "" }}
    {{ with reFindAllSubmatches `<#(\d+)>` (index .CmdArgs 0) }} {{ $channelID = index . 0 1 }} {{ end }}
    {{ $temp := getChannel (or $channelID (index .CmdArgs 0)) }}
    {{ if $temp }}
        {{ $channel = $temp }}
        {{ $msg = slice (index .CmdArgs 1) | joinStr " " }}
    {{ end }}
{{ end }}
{{ if $msg }}
    {{ if eq $type "raw" }}
        {{ sendMessageNoEscape $channel.ID $msg }}
    {{ else }}
        {{ sendMessage $channel.ID (cembed
            "author" (sdict "name" .User.String "icon_url" (.User.AvatarURL "256"))
            "description" $msg
            "color" $dec
            "footer" (sdict "text" (printf "Message sent from #%s" .Channel.Name))
            "timestamp" currentTime
        ) }}
    {{ end }}
    {{ if ne $channel.ID .Channel.ID }}
        Successfully sent message to <#{{ $channel.ID }}>!
    {{ end }}
{{ else }}
    Sorry, you didn't provide anything to say!
{{ end }}
