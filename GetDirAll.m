function [images, folders] = GetDirAll(searchDir, isWindows)
%GETDIRALL List contents of a directory and its subdirectories.
%   [images, folders] = GETDIRALL(searchDir, isWindows) returns two cell
%   arrays: 'folders' containing the paths of all subdirectories, and
%   'images' containing the paths of all files in these directories. 
%
%   'searchDir' is the directory to be searched.
%   'isWindows' is a boolean indicating if the path is for Windows (true)
%   or Unix/Linux (false).

    % Initialize variables
    tempFolders = {searchDir};
    folders = {searchDir};
    images = {};
    folderLayer = 1;
    counterDir = 1;
    counterFile = 1;
    hasMoreFolders = true;

    % Main loop to process directories
    while hasMoreFolders
        tempFoldersNextLayer = {};
        counterDirTemp = 1;
        hasMoreFolders = false;

        for j = 1:length(tempFolders)
            contents = dir(tempFolders{j});
            for i = 3:length(contents) % Skip '.' and '..' entries
                item = contents(i);
                fullPath = fullfile(tempFolders{j}, item.name);

                if item.isdir
                    % Add directory to folders list
                    hasMoreFolders = true;
                    if isWindows
                        folders{folderLayer + 1, counterDirTemp} = fullPath;
                    else
                        folders{folderLayer, counterDirTemp} = fullPath;
                    end
                    tempFoldersNextLayer{counterDirTemp} = fullPath;
                    counterDirTemp = counterDirTemp + 1;
                    counterDir = counterDir + 1;
                else
                    % Add file to images list
                    images{counterFile} = fullPath;
                    counterFile = counterFile + 1;
                end
            end
        end

        % Prepare for next layer of folders
        tempFolders = tempFoldersNextLayer;
        folderLayer = folderLayer + 1;
    end
end