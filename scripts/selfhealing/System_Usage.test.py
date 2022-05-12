import unittest
import System_Usage

class TestStringMethods(unittest.TestCase):

    def test_diskspace_used(self):
        su = System_Usage.SystemUsage()
        su.set_diskspace_used()
        currentUsage = su.get_diskspace_used()
        self.assertGreaterEqual(currentUsage, 0)
        self.assertEqual(isinstance(currentUsage, float), True)
        with self.assertRaises(Exception) as context:
            su.get_diskspace_used('bogus directory')
        self.assertTrue(context.exception)

    def test_memory_used(self):
        su = System_Usage.SystemUsage()
        su.set_memory_used()
        currentUsage = su.get_memory_used()
        print(currentUsage)
        self.assertGreaterEqual(currentUsage, 0)
        self.assertEqual(isinstance(currentUsage, float), True)

    def test_cpu_used(self):
        su = System_Usage.SystemUsage()
        su.set_cpu_used()
        currentUsage = su.get_cpu_used()
        self.assertGreaterEqual(currentUsage, 0)
        self.assertEqual(isinstance(currentUsage, float), True)

    def test_system_usage(self):
        su = System_Usage.SystemUsage()
        su.set_system_usage()
        currentDiskspaceUsage = su.get_diskspace_used()
        currentMemoryUsage = su.get_memory_used()
        currentCpuUsage = su.get_cpu_used()
        
        self.assertGreaterEqual(currentDiskspaceUsage, 0)
        self.assertEqual(isinstance(currentDiskspaceUsage, float), True)

        self.assertGreaterEqual(currentMemoryUsage, 0)
        self.assertEqual(isinstance(currentMemoryUsage, float), True)

        self.assertGreaterEqual(currentCpuUsage, 0)
        self.assertEqual(isinstance(currentCpuUsage, float), True)

    def test_should_alert_false(self):
        su = System_Usage.SystemUsage()
        
        su.diskspaceUsed = 0
        su.memoryUsed = 0
        su.cpuUsed = 0
        self.assertFalse(su.should_alert())
    
        su.diskspaceUsed = 79.999
        self.assertFalse(su.should_alert())
        su.memoryUsed = 79.999
        self.assertFalse(su.should_alert())
        su.cpuUsed = 79.999
        self.assertFalse(su.should_alert())

    def test_should_alert_true(self):
        su = System_Usage.SystemUsage()

        su.diskspaceUsed = 0
        su.memoryUsed = 0
        su.cpuUsed = 0
        self.assertFalse(su.should_alert())

        su.diskspaceUsed = 80
        self.assertTrue(su.should_alert())
        su.diskspaceUsed = 0
        su.memoryUsed = 80
        su.cpuUsed = 0
        self.assertTrue(su.should_alert())
        su.diskspaceUsed = 0
        su.memoryUsed = 0
        su.cpuUsed = 80
        self.assertTrue(su.should_alert())
        su.diskspaceUsed = 0
        su.memoryUsed = 80
        su.cpuUsed = 80
        self.assertTrue(su.should_alert())
        su.diskspaceUsed = 80
        su.memoryUsed = 80
        su.cpuUsed = 80        
        self.assertTrue(su.should_alert())
        su.diskspaceUsed = 100
        su.memoryUsed = 100
        su.cpuUsed = 100
        self.assertTrue(su.should_alert())

        with self.assertRaises(Exception) as context:
            su.cpuUsed = None
            su.should_alert('')
        self.assertTrue(context.exception)

    def test_get_alert_message(self):
        su = System_Usage.SystemUsage()
        su.diskspaceUsed = 80
        su.memoryUsed = 80
        su.cpuUsed = 80
        alertMessage = su.get_alert_message()
        self.assertEqual(isinstance(alertMessage, str), True)

if __name__ == '__main__':
    unittest.main()
