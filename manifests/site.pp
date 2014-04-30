node default {
    notify { "this is a ${::role}": }
    include "::role::${::role}"
}
