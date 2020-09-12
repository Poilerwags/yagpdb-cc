{{/*
	This command allows you to view the avatar of a given user defaulting to yourself.
	Usage: `-avatar [user]`.

	Recommended trigger: Regex trigger with trigger `^-(avatar|av|pfp)`
*/}}

{{ $user := .User }}
{{ $args := parseArgs 0 "**Syntax:** `-avatar [user]`" (carg "userid" "user") }}
{{ if $args.IsSet 0 }}
	{{ $user = userArg ($args.Get 0) }}
{{ end }}
{{$col := 16777215}}{{$p := 0}}{{$r := .Member.Roles}}{{range .Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $p .Position)}}{{$p = .Position}}{{$col = .Color}}{{end}}{{end}}
{{ sendMessage nil (cembed
	"author" (sdict "name" (printf "%s (%d)" $user.String $user.ID) "icon_url" ($user.AvatarURL "256"))
	"title" "❯ Avatar"
	"image" (sdict "url" ($user.AvatarURL "2048"))
	"color" 14232643
) }}
