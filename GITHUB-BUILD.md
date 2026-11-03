# Building the ISO on GitHub (no Linux needed)

1. Make a free account at github.com, click New repository, name it "lyarnix" (Private is fine).
2. Unzip this folder on your PC, then on the repo page click
   "Add file" -> "Upload files", drag in EVERYTHING inside the folder
   (including the hidden .github folder), and Commit.
   If the .github folder won't drag in, see the note below.
3. Open the "Actions" tab -> "Build Lyarnix ISO" -> "Run workflow".
4. Wait 45-90 minutes. When it turns green, open the run and download
   "Lyarnix-ISO" from Artifacts (it is zipped; unzip to get Lyarnix.iso).
5. If it turns red, download the "build-log" artifact (or copy the red error text)
   and send it to Claude.
6. Test Lyarnix.iso in a VM first. Then flash to USB with Rufus or balenaEtcher.

Note on .github: Windows hides folders starting with a dot. In the GitHub repo, you can also
choose "Add file" -> "Create new file", type  .github/workflows/build-iso.yml  as the name,
and paste the contents of that file.
