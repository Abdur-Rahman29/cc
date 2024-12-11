import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

public class App {
    public static void main(String[] args) {
        try {
            // Get the current working directory
            String rootDir = System.getProperty("user.dir");

            // Path to the 'cruise-control-node' folder
            String cruiseNodeDir = Paths.get(rootDir, "cruise-control-node").toString();

            // Run Gradle build
            runCommand(new String[]{"./gradlew", "build"}, rootDir);

            // Check if the cruise_node_dir exists
            File cruiseNodeFolder = new File(cruiseNodeDir);
            if (cruiseNodeFolder.isDirectory()) {
                // Install dependencies
                runCommand(new String[]{"npm", "install", "--force"}, cruiseNodeDir);

                // Run the React app server
                runCommand(new String[]{"node", "server.js"}, cruiseNodeDir);

                // Run Kafka Cruise Control start script in the background
                runCommand(new String[]{"nohup", "sh", "kafka-cruise-control-start.sh", "config/cruisecontrol.properties"}, rootDir);
            } else {
                System.out.println("Error: The directory '" + cruiseNodeDir + "' does not exist.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void runCommand(String[] command, String workingDir) throws IOException, InterruptedException {
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        processBuilder.directory(new File(workingDir));
        processBuilder.inheritIO(); // Redirect output and errors to the console
        Process process = processBuilder.start();
        int exitCode = process.waitFor();

        if (exitCode != 0) {
            throw new RuntimeException("Command failed with exit code: " + exitCode);
        }
    }
}

