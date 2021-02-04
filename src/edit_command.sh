check_logged_in
check_for_project

environment="${args[environment]}"

get_env "$environment" > "$tempdir/cloudenv-edit-$environment"

cp "$tempdir/cloudenv-edit-$environment" "$tempdir/cloudenv-orig-$environment"
"$editor" "$tempdir/cloudenv-edit-$environment"

echo

if cmp --silent "$tempdir/cloudenv-edit-$environment" "$tempdir/cloudenv-orig-$environment"
then
	warn "No changes detected"
else
	upload_env "$tempdir/cloudenv-edit-$environment"
	ohai "Your changes to $app ($environment environment) have been uploaded"
fi

echo

rm -rf "$tempdir"