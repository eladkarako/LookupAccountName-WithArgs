# LookupAccountName-WithArgs
LookupAccountNameA from advapi32.dll - as an easy to use application include VB6 source and ready to use binary (along with Windows 10 compatible manifest)

it does not uses <code>GetUserNameA</code> or <code>GetComputerName</code> internally as <a href="http://github.com/eladkarako/LookupAccountName-NoArgs/">LookupAccountName-NoArgs</a>.
it accepts the user-name as first argument, and optionally machine-name as second argument.

you may specify second-argument as an empty-string or not specify it at-all,
which in that case the "lookup stage" of the <code>LookupAccountNameA</code> will try to discover the user-name,
in this or any other computer it can reach out (local network).

<hr/>

you can specify third argument which is the mode of the output,<br/>
by default the used mode is <code>0</code> which is sid comma domain,<br/>
<code>1</code> means just sid and <code>2</code> means just domain (any other value is just like default <code>0</code>)

<hr/>

<pre>
LookupAccountName-WithArgs.exe
<em>(will return an empty string)</em>

LookupAccountName-WithArgs.exe "Elad" "NonExistingPC"
<em>(will return an empty string)</em>

LookupAccountName-WithArgs.exe "NonExistingUser" "ExistingPC"
<em>(will return an empty string)</em>

LookupAccountName-WithArgs.exe "ExistingUser"
<em>S-1-5-11-12345678910-123456789-0123456789-0123,ExistingPC</em>

LookupAccountName-WithArgs.exe "ExistingUser" "ExistingPC"
<em>S-1-5-11-12345678910-123456789-0123456789-0123,ExistingPC</em>

LookupAccountName-WithArgs.exe "ExistingUser" "ExistingPC" "0"
<em>S-1-5-11-12345678910-123456789-0123456789-0123,ExistingPC</em>

LookupAccountName-WithArgs.exe "ExistingUser" "ExistingPC" "1"
<em>S-1-5-11-12345678910-123456789-0123456789-0123</em>

LookupAccountName-WithArgs.exe "ExistingUser" "ExistingPC" "2"
<em>ExistingPC</em>

<hr/>

LookupAccountName-WithArgs.exe "ExistingUser" "" "0"
<em>S-1-5-11-12345678910-123456789-0123456789-0123,ExistingPC</em>

LookupAccountName-WithArgs.exe "ExistingUser" "" "1"
<em>S-1-5-11-12345678910-123456789-0123456789-0123</em>

LookupAccountName-WithArgs.exe "ExistingUser" "" "2"          <sub>*can help to find if a user exist (and its pc)</sub>
<em>ExistingPC</em>
</pre>

<hr/>

this is a plain usage of <code>LookupAccountNameA</code>, without any extra processing!

<hr/>

Keep in mind that you might want to execute this file with admin permissions,<br/>
for better results (not required by default).

<hr/>

you should look in this repository: <a href="http://github.com/eladkarako/LookupAccountName-NoArgs/">LookupAccountName-NoArgs</a>,<br/>
if you are looking for a faster simpler way of getting the sid string of the current user, on the current machine.
