# MedLabO

## Overview
MedLabO is a sophisticated medical laboratory software solution, offering specialized desktop and mobile applications to cater to the diverse needs of a medical laboratory. It streamlines patient management, administrative tasks, and laboratory operations.

## Key Features
- **Role-Based Access:** Separate access levels for Administrator, MedicinskoOsoblje, and Pacijent.
- **Cross-Platform Support:** Fully functional on both desktop and mobile platforms.
- **Patient Management:** Streamlined management of patient records and lab results.
- **Administrative Tools:** Extensive admin features for user and data management.

## Applications

### Mobile Application
**Purpose:** Provides patients with access to their test results, appointment scheduling, and service browsing.

**Technology:** Built with Flutter, offering a responsive and intuitive interface. Key plugins: `flutter_stripe` for payment processing, `syncfusion_flutter_pdfviewer` for viewing PDFs, `persistent_bottom_nav_bar` for navigation.

**Features:**
- View and manage test results.
- Schedule and track appointments.
- Browse laboratory services.

### Desktop Application
**Purpose:** Designed for laboratory staff and administrators for managing laboratory operations, patient records, and administrative tasks.

**Technology:** Developed using Flutter for desktop, ensuring a consistent user experience across platforms. Key plugins: `syncfusion_flutter_pdfviewer` for PDF viewing, `file_picker` for file management, `flutter_secure_storage` for secure storage.

**Features:**
- Comprehensive patient management.
- Appointment scheduling and management.
- Administrative controls for user and data management.

### API
**Technology:** The API is built using ASP.NET, providing a robust backend for both the mobile and desktop applications.

**Features:** Handles user authentication, data management, and integration with external services like Stripe for payments and ML.NET for service recommendations.

## Technologies, Libraries, and Plugins
- **Flutter:** Primary framework for both mobile and desktop applications.
- **ML.NET:** Used for collaborative filtering to recommend services to patients.  
  Location in Code: `MedLabO.Services.UslugaService.Recommend`
- **Stripe:** Integrated for secure online payments.  
  Location in Code: `MedLabO.Controllers.StripeController`
- **RabbitMQ:** Utilized for message queuing and handling.  
  Publishing Messages: Code for publishing messages to the RabbitMQ client can be found at `MedLabO.Services.TerminService.AfterInsert`.

## Getting Started
**Prerequisites:**
- Flutter SDK
- Dart
- Docker
- Docker Compose

**Installation:**
- Clone the MedLabO repository: `git clone https://github.com/etjenB/MedLabO.git`
- Navigate to the project directory.
- To run the Flutter application: `flutter run -d |specify device/platform|`

**Running the Dockerized API, Database, and RabbitMQ:**
- Ensure Docker and Docker Compose are installed on your system.
- Navigate to the root directory of the cloned repository.
- Build the container: `docker build . -t |name of container|`
- Start all services: `docker-compose up -d`
- Check the status of the containers: `docker-compose ps`
- The API, database, and RabbitMQ services will be accessible on their respective ports as defined in the docker-compose.yml file.
- To stop the services: `docker-compose down`

## Credentials for Testing
**Mobile Application:**
- Username: pacijent
- Password: test

**Desktop Application:**
- Administrator:
  - Username: administrator
  - Password: test
- MedicinskoOsoblje:
  - Username: medicinskoOsoblje
  - Password: test
  
## Test Payment Information
**For testing online payments, use these dummy credit card details:**
- Card Number: 4242 4242 4242 4242
- Expiration Date: Any future date
- CVV: Any 3 digits

## Contributing
Contributions to MedLabO will be welcome in the near future. Stay tuned for updates.

## License
This project is licensed under the MIT License.

## Contact
For any inquiries, you can contact me through LinkedIn: https://www.linkedin.com/in/etjen/
