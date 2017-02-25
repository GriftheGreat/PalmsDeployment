# PalmsDeployment
<p>
	The final PalmsGO repository.<br />
	Any files needed to be ported over can be done so by:<br />
	Uploading files from the old repository to the new one through the website.<br />
	Or<br />
	Moving files from your local old repo to your local new repo, then commiting and pushing.
</p>
<br />

<h1>Policy for updating files on the server:</h1>
<p>
	Limit direct editing of these files.<br />
	Modify corresponding files on github branch then pull changes.
</p>
<br />

<h1>Procedure for updating files on the server:</h1>
<ol>
	<li>Pull changes to your local.</li>
	<li>Commit your local changes.</li>
	<li>Push your local changes.</li>
	<li>Start git bash in the server folder.</li>
	<li>Run command <pre>git pull origin master</pre> (it will fail).</li>
	<li>Run command <pre>git checkout -f master</pre> the whole folder is mirrored.</li>
</ol>