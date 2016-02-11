Definitions.

IDENTIFIER = [-A-Za-z0-9_]+
QUOTED = (\".*\"|\'.*\')
SYMBOL = [\[\]*]
W = [\s\t\r\n\f]

Rules.

{IDENTIFIER}     : {token, {identifier, TokenLine, TokenChars}}.
{QUOTED}         : {token, {quoted, TokenLine, remove_quotes(TokenChars)}}.
{SYMBOL}         : {token, {TokenChars, TokenLine}}.
#{IDENTIFIER}    : {token, {hash, TokenLine, tail(TokenChars)}}.
\.{IDENTIFIER}   : {token, {class, TokenLine, tail(TokenChars)}}.
:first           : {token, {pseudo_first, TokenLine}}.
:last            : {token, {pseudo_last, TokenLine}}.
~=               : {token, {includes, TokenLine}}.
\|=              : {token, {dash_match, TokenLine}}.
\^=              : {token, {prefix_match, TokenLine}}.
\$=              : {token, {sufix_match, TokenLine}}.
\*=              : {token, {substring_match, TokenLine}}.
=                : {token, {equal, TokenLine}}.
{W}*,            : {token, {comma, TokenLine}}.
{W}*>{W}*        : {token, {greater, TokenLine}}.
{W}*\+{W}*       : {token, {plus, TokenLine}}.
{W}*~{W}*        : {token, {tilde, TokenLine}}.
{W}+             : {token, {space, TokenLine}}.
.                : {token, {unknown, TokenLine, TokenChars}}.


Erlang code.

remove_quotes(Chars) ->
  Len = string:len(Chars),
  string:substr(Chars, 2, Len - 2).

tail([_|T]) ->
  T.
