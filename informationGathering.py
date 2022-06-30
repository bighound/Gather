#!/usr/bin/python3

import requests
import argparse
import sys
import os
from pyfiglet import Figlet

def main():
    os.system("clear")
    custom_fig = Figlet(font='pagga')
    print("\n")
    print(custom_fig.renderText('Big Hound'))

    parser = argparse.ArgumentParser(description='Information Gathering for Bug Bounty/Pentesting')
    parser.add_argument('-d', dest='domain', help='domain help')
    if len(sys.argv)!=3:
        parser.print_help(sys.stderr)
        sys.exit(1)
   
    args = parser.parse_args()
    # Ejecutar en varios hilos las distintas funciones (¿Crear semáforos mutex?)
    # Ejecutar sublist3r -d {}.format(args.dom)  o mejor el amass
    # subdomains(args.domain)
    listDomains(args.domain)
    dorking(args.domain)
    leakedInfo(args.domain)

def dorking(dom):
    extensions=["xls","xlsx","php","txt","doc","docx","ppt","pptx","db","sql","bak","html","py","c","jsp"]
    openredirects=["url=https","url=http","u=https","u=http","redirect?https","redirect?http","redirect=https","redirect=http","link=http","link=https","?page="]
    print(" \n\n----- Google Dorking -----\n\n")
    print("[+] Dorks:\n\n")
    print("    Get indexed information about files --> ",end="")
    for ext in extensions:
        print("site:*.{} ext:{}\n                                            ".format(dom,ext),end="")

    print("\n")
    print("    Open Redirect                       --> ",end="")
    for red in openredirects:
        print("site:*.{} inurl:{}\n                                            ".format(dom,red),end="")

    print("\n")
    print("    [+] Try this to bypass Open Redirect/SSRF protections --> https://tools.intigriti.io/redirector/#")

def leakedInfo(dom):
    print("\n\n----- Information Leaked -----\n\n")
    print("[+] Github: \n\n    org:{}\n".format(dom))
    print("[?] Is there a project on github? Try running the following: \n\n    trufflehog github --only-verified --repo https://github.com/project.git\n") 
    print("[+] Way Back Machine --> https://web.archive.org/\n\n    Ex: https://web.archive.org/web/*/https://www.{}/*\n".format(dom))
    print("[+] Subdomain TakeOver --> Search in missing subdomains")
    print("\n   https://dnsdumpster.com/")
    # Ejecutar 
    # Subdomain TakeOver

def listDomains(dom):
    print("\n\n----- Listing Subdomains -----\n\n")
    dictionary = input("[?] Which dictionary do you want use? [Default: dictionaries/DNS/subdomains-top1million-5000.txt]: ")
    if dictionary == "":
        dict = "dictionaries/DNS/subdomains-top1million-5000.txt"
    else:
        dict = dictionary

    os.system("mkdir -p ./{}/outputs/gobuster/".format(dom))
    os.system("gobuster dns -w {} -d {} -q -z -o ./{}/outputs/gobuster/res.txt".format(dict, dom, dom))
    os.system("cat ./{}/outputs/gobuster/res.txt | tr -d ' ' | cut -d ':' -f2 > ./{}/outputs/gobuster/results.txt".format(dom, dom))
    os.system("rm ./{}/outputs/gobuster/res.txt".format(dom))
    os.system("mkdir -p ./{}/outputs/massdns/".format(dom))
    os.system("./massdns/bin/massdns -r ./massdns/lists/resolvers.txt -o S -w ./{}/outputs/massdns/resolved.txt ./{}/outputs/gobuster/results.txt".format(dom, dom))
    os.system("./EyeWitness/Python/EyeWitness.py -f ./{}/outputs/massdns/resolved.txt --web".format(dom))




if __name__ == '__main__':
    main()



