package com.example.demo;



/**
 * @author Rob Winch
 *
 */
//@Service
public class SpringDataUserDetailsService {
//	@Autowired
//	private UserMapper mapper;
//	
//    @Autowired
//    public SpringDataUserDetailsService(UserMapper mapper) {
//        this.mapper = mapper;
//    }
//
//    public SpringDataUserDetailsService() {
//		// TODO Auto-generated constructor stub
//	}
//
//	/* (non-Javadoc)
//     * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
//     */
//    @Override
//    public UserDetails loadUserByUsername(String username)
//            throws UsernameNotFoundException {
//        User user = mapper.findByEmail(username);
//        user.setEmail("teda");
//        user.setFirstName("Mathew");
//        user.setId(1L);
//        user.setLastName("");
//        user.setPassword("123");
////        if(user == null) {
////            throw new UsernameNotFoundException("Could not find user " + username);
////        }
//        return new CustomUserDetails(user);
//    }
//
//    private final static class CustomUserDetails extends User implements UserDetails {
//
//        private CustomUserDetails(User user) {
//            super(user);
//        }
//
//        @Override
//        public Collection<? extends GrantedAuthority> getAuthorities() {
//            return AuthorityUtils.createAuthorityList("ROLE_USER");
//        }
//
//        @Override
//        public String getUsername() {
//            return getEmail();
//        }
//
//        @Override
//        public boolean isAccountNonExpired() {
//            return true;
//        }
//
//        @Override
//        public boolean isAccountNonLocked() {
//            return true;
//        }
//
//        @Override
//        public boolean isCredentialsNonExpired() {
//            return true;
//        }
//
//        @Override
//        public boolean isEnabled() {
//            return true;
//        }
//
//        private static final long serialVersionUID = 5639683223516504866L;
//    }
}