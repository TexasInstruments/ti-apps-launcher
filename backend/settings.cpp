#include "includes/settings.h"
#include <iostream>
#include <filesystem>
#include <stdlib.h>
#include <unordered_map>
#include <sys/stat.h>
#include <sys/types.h>

using namespace std;

unordered_map<string, string> proxy_list;

void set_environment_variables() {
    // Setting up Environment Variables
    string command = "echo https_proxy=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo HTTPS_PROXY=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo HTTP_PROXY=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo http_proxy=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo ftp_proxy=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo FTP_PROXY=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    command = "echo no_proxy=" + proxy_list["no_proxy"] + " | sudo tee -a /etc/environment";
    system(command.c_str());
    
    setenv("https_proxy",proxy_list["https_proxy"].c_str(),1);
    setenv("http_proxy",proxy_list["https_proxy"].c_str(),1);
    setenv("ftp_proxy",proxy_list["https_proxy"].c_str(),1);
    setenv("no_proxy",proxy_list["no_proxy"].c_str(),1);
    setenv("HTTPS_PROXY",proxy_list["https_proxy"].c_str(),1);
    setenv("HTTP_PROXY",proxy_list["https_proxy"].c_str(),1);
    setenv("FTP_PROXY",proxy_list["https_proxy"].c_str(),1);
}


void apply_docker_proxy() {
    // Create /etc/systemd/system/docker.service.d directory structure
    if(system("sudo mkdir -p /etc/systemd/system/docker.service.d") == -1){
        cout << "Failed to create directory structure for docker proxies" << endl;
        exit(0);
    }
    
    // Write the docker proxy setting
    string apply_systemd_proxy = "echo [Service] | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(apply_systemd_proxy.c_str());
    
    apply_systemd_proxy = "echo Environment=HTTPS_PROXY=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(apply_systemd_proxy.c_str());
    
    apply_systemd_proxy = "echo Environment=HTTP_PROXY=" + proxy_list["https_proxy"] + " | sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(apply_systemd_proxy.c_str());
    
    apply_systemd_proxy = "echo Environment=NO_PROXY=" + proxy_list["no_proxy"] + " | sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(apply_systemd_proxy.c_str());
    
    // Flush changes, Re-load Daemon and Re-Start Docker
    string str = "sudo systemctl daemon-reload";
    const char *command = str.c_str();
    system(command);
     
    str = "sudo systemctl restart docker";
    command = str.c_str();
    system(command);
}

void Settings::set_proxy(QString https_proxy, QString no_proxy) {
    Settings::_https_proxy=https_proxy;
    Settings::_no_proxy=no_proxy;
        
    cout << "Setting https_proxy to " << https_proxy.toStdString() << endl;
    cout << "Setting no_proxy to " << no_proxy.toStdString() << endl;

    proxy_list["https_proxy"] = https_proxy.toStdString();
    proxy_list["no_proxy"] = no_proxy.toStdString();
    
    apply_docker_proxy();
    set_environment_variables();
    
    cout << "Applied Proxy Settings!" << endl;
}
