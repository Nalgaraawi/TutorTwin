import SwiftUI
import UniformTypeIdentifiers

struct VolunteerVerificationView: View {
    private let institutions = [
        "University of Michigan",
        "Michigan State University",
        "Wayne State University",
        "Western Michigan University",
        "Eastern Michigan University",
        "Central Michigan University",
        "Northern Michigan University",
        "Michigan Technological University",
        "Grand Valley State University",
        "Oakland University",
        "Ferris State University",
        "Saginaw Valley State University",
        "Lake Superior State University",
        "Andrews University",
        "Aquinas College",
        "Calvin University",
        "Cornerstone University",
        "Davenport University",
        "Hope College",
        "Kalamazoo College",
        "Kettering University",
        "Lawrence Technological University",
        "Madonna University",
        "Olivet College",
        "Siena Heights University",
        "Spring Arbor University",
        "Walsh College",
        "Baker College",
        "Grand Rapids Community College",
        "Henry Ford College",
        "Jackson College",
        "Lansing Community College",
        "Macomb Community College",
        "Monroe County Community College",
        "Muskegon Community College",
        "Schoolcraft College",
        "Washtenaw Community College",
        "Kalamazoo Valley Community College",
        "Kellogg Community College",
        "Northwestern Michigan College",
        "Delta College",
        "Mid Michigan College",
        "Lake Michigan College"
    ]

    @State private var searchText = ""
    @State private var selectedInstitution = ""
    @State private var showDropdown = false
    @State private var uploadedFileName = ""
    @State private var showFilePicker = false

    var filteredInstitutions: [String] {
        searchText.isEmpty
            ? institutions
            : institutions.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Select Institution")
                    .font(AppTheme.gotu(34))
                    .minimumScaleFactor(0.65)
                    .lineLimit(1)
                    .padding(.top, 25)

                // Search bar + dropdown
                VStack(spacing: 0) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)

                        TextField("Search Michigan institutions...", text: $searchText, onEditingChanged: { editing in
                            if editing { showDropdown = true }
                        })
                        .onChange(of: searchText) { _ in showDropdown = true }

                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                                selectedInstitution = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.gray)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 62)
                    .background(Color.white.opacity(0.9))
                    .clipShape(
                        RoundedRectangle(cornerRadius: showDropdown && !filteredInstitutions.isEmpty ? 18 : 30)
                    )

                    if showDropdown && !filteredInstitutions.isEmpty {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(filteredInstitutions, id: \.self) { institution in
                                    Button {
                                        selectedInstitution = institution
                                        searchText = institution
                                        showDropdown = false
                                    } label: {
                                        HStack {
                                            Text(institution)
                                                .font(.system(size: 16))
                                                .foregroundStyle(selectedInstitution == institution ? AppTheme.primaryBlue : .black)
                                                .frame(maxWidth: .infinity, alignment: .leading)

                                            if selectedInstitution == institution {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundStyle(AppTheme.primaryBlue)
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 14)
                                        .background(
                                            selectedInstitution == institution
                                                ? AppTheme.primaryBlue.opacity(0.08)
                                                : Color.white
                                        )
                                    }
                                    .buttonStyle(.plain)

                                    if institution != filteredInstitutions.last {
                                        Divider()
                                            .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: 230)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .animation(.easeInOut(duration: 0.2), value: showDropdown)

                Text("Proof of attendance")
                    .font(AppTheme.gotu(28))
                    .minimumScaleFactor(0.75)

                Text("Upload documents to verify status (transcript, School ID, Letter of Acceptance)")
                    .foregroundStyle(.gray)
                    .font(.body)

                // Tappable upload area
                Button {
                    showFilePicker = true
                } label: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.gray.opacity(0.10))
                        .frame(height: 260)
                        .overlay {
                            if uploadedFileName.isEmpty {
                                VStack(spacing: 14) {
                                    Image(systemName: "arrow.up.doc.fill")
                                        .font(.system(size: 48))
                                        .foregroundStyle(AppTheme.primaryBlue.opacity(0.55))
                                    Text("Tap to upload document")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.gray)
                                    Text("PDF · JPG · PNG")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.gray.opacity(0.55))
                                }
                            } else {
                                VStack(spacing: 12) {
                                    Image(systemName: "doc.fill.badge.checkmark")
                                        .font(.system(size: 48))
                                        .foregroundStyle(.green)
                                    Text(uploadedFileName)
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundStyle(.black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                    Text("Tap to replace")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                }
                .buttonStyle(.plain)
                .animation(.easeInOut, value: uploadedFileName)

                HStack(spacing: 25) {
                    // Redo — clears institution and uploaded file
                    Button {
                        searchText = ""
                        selectedInstitution = ""
                        uploadedFileName = ""
                        showDropdown = false
                    } label: {
                        CircleIconButton(systemName: "arrow.uturn.left")
                    }
                    .buttonStyle(.plain)

                    // Upload — opens file picker
                    Button {
                        showFilePicker = true
                    } label: {
                        CircleIconButton(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.plain)

                    // Confirm — navigate to interests
                    NavigationLink(destination: MentorSignUpView()) {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .foregroundStyle(.black)
                            .frame(width: 58, height: 58)
                            .background(AppTheme.primaryBlue)
                            .clipShape(Circle())
                            .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 22)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: [.pdf, .image],
            allowsMultipleSelection: false
        ) { result in
            if case .success(let urls) = result, let url = urls.first {
                uploadedFileName = url.lastPathComponent
            }
        }
        .onTapGesture {
            if showDropdown { showDropdown = false }
        }
    }
}
