Needs polished up but will do for now. 

I think I changed all of the paths to be generic /path/to/your/data style things, but double check just to be safe. These should all be placed in your /workspace/scripts directory and when you are calling them it is assumed you are in /workspace. e.g.

$ pwd
> /scratch365/nmcadam2/workspace

$qsub ./scripts/trimming.sh

in other words don't go down into the script directory to run them, nor should you copy them into your regular workspace directory. If you have any questions email me
