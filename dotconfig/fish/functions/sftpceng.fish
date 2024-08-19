function sftpceng --wraps='sftp -oPort=8085 e2448140@external.ceng.metu.edu.tr' --description 'alias sftpceng sftp -oPort=8085 e2448140@external.ceng.metu.edu.tr'
  sftp -oPort=8085 e2448140@external.ceng.metu.edu.tr $argv
        
end
