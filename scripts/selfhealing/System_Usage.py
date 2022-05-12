#! /usr/bin/python3
import psutil
import shutil
import os
from dotenv import load_dotenv
import Slack_Messaging as Slack_Messaging

load_dotenv('../.env')

ENVIRONMENT = os.environ.get('environment')

if ENVIRONMENT is None:
    raise ValueError('environment variable not set in .env')
    
class SystemUsage:
    def __init__(self):
        self.diskspaceUsed = None
        self.memoryUsed = None
        self.cpuUsed = None

    def set_diskspace_used(self, directory: str='/') -> None:
        disk_usage = shutil.disk_usage(directory)
        self.diskspaceUsed = round((disk_usage.used / disk_usage.total)*100, 2)

    def set_memory_used(self) -> None:
        self.memoryUsed = psutil.virtual_memory()[2]

    def set_cpu_used(self, testDuration: int=0) -> None:
        self.cpuUsed = psutil.cpu_percent(testDuration)

    def set_system_usage(self) -> None:
        self.set_diskspace_used('/')
        self.set_memory_used()
        self.set_cpu_used()

    def get_diskspace_used(self) -> float:
        return self.diskspaceUsed

    def get_memory_used(self) -> float:
        return self.memoryUsed

    def get_cpu_used(self) -> float:
        return self.cpuUsed

    def should_alert(self):
        if self.diskspaceUsed >= 80:
            return True

        if self.memoryUsed >= 80:
            return True

        if self.cpuUsed >= 80:
            return True

        return False
    
    def get_alert_message(self) -> str:
        message = f'''
            System usage on {ENVIRONMENT} is abnormally high.
            Diskspace usage - {self.diskspaceUsed}%
            Memory usage - {self.memoryUsed}%
            CPU usage - {self.cpuUsed}%'''
        return message

if __name__ == "__main__":
    su = SystemUsage()
    su.set_system_usage()
    if su.should_alert():
        Slack_Messaging.send_slack_message(su.get_alert_message())