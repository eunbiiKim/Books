import Foundation

// Entity를 가져오는 기능
struct Repository {
    
    func loadData(completionHandler: @escaping (Entity) -> Void) {

        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // client-side error
            guard error == nil else { return }

            // server-side error
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else {
                // alertview 띄우기
                print("statusCode: \(statusCode)")
                return
            }
            do {
                guard let _data = data else { return }

                let entity = try JSONDecoder().decode(Entity.self, from: _data)

                completionHandler(entity)

            } catch let error {
                print("error: \(error.localizedDescription)")
                // FIXME: - alert view
            }
        }.resume()
    }
}
