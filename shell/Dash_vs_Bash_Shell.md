# Dash vs Bash Shell

The Dash vs Bash Shell comparison is  becoming very popular. Bash Shell is better known and it comes with most of the Linux distros by default, but Dash Shell has some different key  features that are very attractive. Which should you choose? Read this  comparison and find out which is best suited for your needs. Remember,  this is Linux, so whatever distribution you have, you can change your  shell and use the one that serves you better. 

## **What is a shell?** 

We can’t talk about Dash vs Bash Shell  without understanding what a shell is. It is an interface, a command  line (CLI), or a graphic interface (GI) that allows people to access the services inside an operating system (OS). These shells create a  communication bridge between you (the user) and the OS kernel. You can  use scripting, command execution, and automation to interact with the  kernel.
 Each command line has its own syntax. Inside  it, you have a list of commands written in a specific language. The word shell comes as a reference to the outside layer of the OS.
 The shell is an application and uses the  kernel API in the same way as the rest of the applications. This is why  it is replaceable. There are many options for Linux with differences in  syntax, commands, speed, and capabilities. 

## **How does the** **shell work?** 

When you input a command in your preferred shell, this is what happens: 

- The shell will parse the command. 
- After that, it will identify the built-in function or program, associated with the command you typed. 
- The request reaches the Linux kernel, and it will execute the command. 
- Depending on the command and the shell, you will see the output displayed (if this applies to the command you typed). 

**Example** 

Use Bash and type the following command: “***ls -l\***”. 

The device will recognize the “***ls\***” (list) command. After that, it will read the flag “***-l\***” (long) which triggers the kernel to display details in the long format  (permissions, owner, size, etc.). The operation will run and you will  see the result. 

# **What is Bash? (/bin/bash)** 

Bash (Bourne Again Shell) is one of those  shells with a command-line interface CLI. It was created by Brian Fox in 1989, more than 30 years ago, for the GNU Project, so it is  open-source. The goal was to provide a free replacement for the  previously used Bourne shell (sh). Now it is the default shell in many  Linux distributions, and older macOS (up to macOS Mojave 10.14). You can still install it on newer macOS and Windows computers.
 One very important characteristic of Bash is  that it makes it possible to run scripts. You can create a code that can combine various commands and run it, instead of writing the commands  one by one.
 Another great advantage of this software is  that it supports interactive features. You (the user) can interact in  real-time with the command line and use extras like shortcuts, command  history, auto-completion, and live feedback.
 Since it is extremely popular, you can find tutorials all over the Internet. We found a very good course from [Learn Linux TV](https://www.youtube.com/watch?v=2733cRPudvI&list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w), so you can check it if you like.
 You will find Bash, as the default option in the following Linux distros: [CentOS Stream](https://blog.neterra.cloud/en/what-is-centos-stream-the-future-after-centos-8s-end/), Arch Linux, Fedora, RHEL, openSUSE, Manjaro, Kali Linux, Slackware, Solus, Void Linux, and more. 

 By the way, check out these [5 excellent Linux distributions for your servers](https://blog.neterra.cloud/en/5-excellent-linux-distributions-for-your-servers/) and if you still have no servers, you can check out our [cloud servers](https://client.neterra.cloud/index.php?/cart/cloud-servers/). We have many great options and custom solutions for your needs. 

#  **What is Dash? (/bin/dash)** 

Dash is another shell. The full name is  Debian Almquist Shell. It is significantly smaller than Bash and,  something very important, it is POSIX-compliant. The small size makes it really lightweight, and in many cases, it can be as 4 times faster than Bash. It is ideal for minimal environments.
 It comes from the NetBSD of another shell  called The Almquist Shell (Ash). It got its name in 1997. It is another  application that interprets commands made for Linux.
 When comparing Dash and Bash, we can see that the first is created for non-interactive sessions. It is mostly used  for system scripts.

It is the default shell in [Ubuntu](https://blog.neterra.cloud/en/what-is-ubuntu-why-and-how-do-people-use-ubuntu/) and [Debian](https://blog.neterra.cloud/en/what-is-debian-and-who-uses-it/). You will also find it inside the distros, based on the two, including Lubuntu, Kubuntu, Xubuntu, Raspberry Pi OS, and more. 

#  **Dash vs Bash Shell** 

This comparison table will help you answer quickly, which are the key differences between the two shells. 

| Feature                   | Dash                                                         | Bash                                                         |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Speed                     | Fast, thanks to its light way. This makes it ideal for init scripts. | Slower, because of its advanced features.                    |
| Memory usage              | Uses less memory which makes it good for resource-constrained environments and embedded systems. | Uses more memory due to its advanced features.               |
| POSIX compliance          | Yes, fully compliant.                                        | No. It has some extensions that are not POSIX-compliant, making it less portable. |
| Scripting Support         | Yes.                                                         | Yes.                                                         |
| Interactive features      | No, it does not support.                                     | Yes, it does support many interactive features like logs, aliases, tab completion, etc. |
| Aliases and customization | No.                                                          | Yes. You can create aliases for commonly used commands like “alias ll=’ls -l’”. |
| History log               | No.                                                          | Yes. You can access “~/.bash_history” and see the previously executed commands. |
| Tab auto-completion       | No.                                                          | Yes. You can use this feature with the “Tab” button.         |
| Arrays                    | No.                                                          | Yes, it does support arrays, which allow users to store multiple values in a single one. |
| Function support          | Yes.                                                         | Yes, and it is a bit more flexible than Dash.                |
| Pipe Support              | Yes.                                                         | Yes.                                                         |
| Job Control               | No.                                                          | Full job support with background (bg) and foreground (fg) jobs. Bash also lets you manage job states (jobs). |
| Error handling            | Fast and simple error handling.                              | Detailed error handling and debugging options.               |

#  **When to use Bash?** 

- **Interactive use**. If you need all the advanced features it offers like command history,  aliases, tab completion, custom prompts, and job control you should  choose Bash. 

- **Scripting complex tasks**. Using this shell you can perform advanced string manipulations, arrays, and data structures, use extensive built-in functions, take advantage  of supported external utilities, and debugging support. 

- **Use if portability is not important**. If you know that the script won’t be ported to a different Unix-like system, you can freely choose it. 

#  **Don’t use Bash if…** 

- **The environment is resource-constrained**. We mentioned already, but it is more resource-hungry, which makes it  not so good choice for embedded systems and minimal servers. It also  takes longer to load on startup. 

- **Don’t use it if your script must be POSIX-compliant**. If it needs to run on multiple systems, it is better to choose Dash. 

- **Avoid Bash if simplicity is key**. If you need a more simple tool, just go with Dash. 

#  **When should you use Dash?** 

- **System startup scripts**. There is no doubt that it is faster for this purpose. 

- **Embedded systems**. It takes just a few kilobytes which makes it perfect for devices with low memory footprints. 

- **Lightweight servers**. It uses very few resources so it is ideal for this purpose. 

- **Strict POSIX environments**. As we mentioned, it is fully compliant, so it ensures compatibility across different systems. 

#  **Don’t use Dash if…** 

- **You write complex scripts with arrays**. For that purpose go for Bash. 

# **How to check if I have Dash or Bash?** 

That is very easy, just open the Terminal and type “***echo $0\***”. If the response is “***-dash\***” then you have Dash installed. If the answer is “***-bash\***”, you have the second option. 

# **Final words** 

Now our Dash vs Bash comparison is  complete. Using this information, you can easily choose which of these  tools is better for your needs. Basically, if you need a fast, simple,  and light solution go for Dash. If you need advanced features, and you  don’t mind that it will take longer to load, Bash is the answer.
 Now, if you want to expand your knowledge even further you can read about the following commands: 

- [Traceroute command](https://blog.neterra.cloud/en/traceroute-command-a-k-a-tracert-command/) 

- [Ping command](https://blog.neterra.cloud/en/what-is-the-ping-command/) 

- [Host command](https://blog.neterra.cloud/en/host-command-linux-probing-your-dns/) 

- [Dig command](https://blog.neterra.cloud/en/linux-dig-command-for-network-diagnostics/) 

- [NSlookup command](https://blog.neterra.cloud/en/nslookup-command-and-10-easy-examples/) 

- [Netstat](https://blog.neterra.cloud/en/what-is-netstat-and-how-to-use-it/) 

Mastering them will give you additional skills that will make your job easier and faster. 




# Major difference between bash and dash
Here are the common bashisms I most often fall afoul of:

- `[[`: the `[[ condition ]]` construct isn't supported by `dash`, you need to use `[ ]` instead.
- `==` : to test if two values are equal, use `=` in dash since `==` is not supported.
- `source`: the POSIX command for sourcing a script is `.`. The `source` builtin is a bash alias to the standard `.`, so always use `. file` instead of `source file`.
- `shopt`: this is a bash builtin that sets certain non-standard options. Not supported by `dash`.
- `$RANDOM`: this is set to a random number on each use in `bash`, but doesn't work in `dash`.