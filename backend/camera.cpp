#include "includes/camera.h"
#include <filesystem>
#include <QDebug>

string Camera::replaceAll(string str, const string &remove, const string &insert) {
    string::size_type pos = 0;
    while ((pos = str.find(remove, pos)) != string::npos) {
        str.replace(pos, remove.size(), insert);
        pos++;
    }

    return str;
}

string Camera::trimString(string str) {
    string stripString = str;
    while(!stripString.empty() && isspace(*stripString.begin()))
        stripString.erase(stripString.begin());

    while(!stripString.empty() && isspace(*stripString.rbegin()))
        stripString.erase(stripString.length()-1);

    return stripString;
}

Camera::Camera() {
    // get_camera_info(cameraInfo);
}

// Get and Populate CameraInfo to CameraList
void Camera::get_camera_info(map<string, map<string,string>> &cameraInfo)
{
    QStringList list = Camera_list.stringList();
    // Get camera info from setup_camera script
    string command = "bash /opt/ti-apps-launcher/setup_cameras.sh";
    array<char, 128> buffer;
    string result;
    unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }

    vector<string> split_string{};
    auto ss = stringstream{result};
    unsigned int i,j;

    for (string line; getline(ss, line, '\n');) {
        qDebug() << QString::fromStdString(line);
        split_string.push_back(line);
    }

    for(i = 0; i < split_string.size(); i++) {
        if (split_string[i].find("detected") != string::npos) {
            string cameraName = replaceAll(split_string[i],"detected","");
            cameraName = trimString(cameraName);

            map<string, string> info{};
            for (j = i+1; j < split_string.size(); j++) {
                if (split_string[j].find("detected") != string::npos) {
                    break;
                }

                char *token;
                token = strtok(&split_string[j][0], "=");
                string key = trimString(token);
                token =  strtok(NULL, "=");
                string value = trimString(token);
                info[key] = value;
            }
            if (info.size() > 0) {
                cameraInfo[cameraName] = info;
            }
        }
    }
    for ( const auto &data : cameraInfo ) {
        for ( const auto &detailedData : data.second )
        {
            if (detailedData.first.find("device") != string::npos)
            {
                string fullName,device;
                device = replaceAll(detailedData.first,"device","");
                device = trimString(device);
                fullName = data.first;
                if (device.length() > 0)
                    fullName += " " + device;
                list.append(QString::fromStdString(fullName));
            }
        }
    }
    Camera_list.setStringList(list);

    Camera_count = Camera_list.rowCount();
}

QString Camera::get_camera_name(int index) {
    return Camera_list.stringList().at(index);
}

int Camera::get_count() {
    cameraInfo.clear();
    Camera_count = 0;
    for (int i = Camera_list.rowCount(); i > 0; i--) {
        Camera_list.removeRow(--i);
    }
    get_camera_info(cameraInfo);
    return Camera_count;
}

QString Camera::codec = "h264";
void Camera::update_codec(bool codec_choice) {
    if (codec_choice == true) {
        codec = "h265";
    }
    else {
        codec = "h264";
    }

    qDebug() << "Codec Selected: " << codec;
}

QString Camera::play_camera(QString camera) {
    _camera = camera;
    gst_pipeline = "gst-pipeline: ";
    gst_pipeline.append("v4l2src device=");
    gst_pipeline.append(QString::fromStdString((cameraInfo[_camera.toStdString()]["device"])));
    #if defined(SOC_AM62) || defined(SOC_AM62_LP) || defined(SOC_AM62P)
    gst_pipeline.append(" ! video/x-raw, width=640, height=480, format=UYVY");
    #elif defined(SOC_J721E) || defined(SOC_J721S2) || defined(SOC_J784S4)
    gst_pipeline.append(" ! image/jpeg, width=1280, height=720 ! jpegdec");
    #endif
    gst_pipeline.append(" ! videoconvert");
    gst_pipeline.append(" ! qtvideosink");
    qDebug() << "New Gst Pipeline: " << gst_pipeline;
    return gst_pipeline;
}

QString Camera::get_gst_pipeline() {
    return gst_pipeline;
}

QString Camera::play_video(QString videofile) {
    _videofile = videofile;
    gst_pipeline = "gst-pipeline: ";
    gst_pipeline.append("filesrc location=");
    gst_pipeline.append(videofile);
    gst_pipeline.append(" ! ");
    gst_pipeline.append(codec);
    gst_pipeline.append("parse ! v4l2");
    gst_pipeline.append(codec);
    gst_pipeline.append("dec capture-io-mode=dmabuf ! qtvideosink");
    qDebug() << "New Gst Pipeline: " << gst_pipeline;
    return gst_pipeline;
}

void Camera::delete_video(QString videofile) {
    _videofile = videofile;
    string full_filename = "/opt/ti-apps-launcher/gallery/" + _videofile.toStdString();

    try {
        if (std::filesystem::remove(full_filename))
            std::cout << "file " << full_filename << " deleted.\n";
        else
           std::cout << "file " << full_filename << " not found.\n";
    }
    catch(const std::filesystem::filesystem_error& err) {
        std::cout << "filesystem error: " << err.what() << '\n';
    }
}

