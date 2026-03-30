% ===== KOA Combined Output | contract_id: contrato_ocs_028_2022 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_028_2022_-_Telsinc.pl
% contract_id: contrato_ocs_028_2022

instance_of(contrato_ocs_028_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(telsinc_comercio_de_equipamentos_de_informatica_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_028_2022).
plays_role(telsinc_comercio_de_equipamentos_de_informatica_ltda, hired_service_provider_role, contrato_ocs_028_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_028_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_028_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_028_2022).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_028_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_028_2022).
clause_of(clausula_sexta_preco, contrato_ocs_028_2022).
clause_of(clausula_setima_pagamento, contrato_ocs_028_2022).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_028_2022).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_028_2022).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_028_2022).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_028_2022).
clause_of(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, contrato_ocs_028_2022).
clause_of(clausula_decima_terceira_sigilo_das_informacoes, contrato_ocs_028_2022).
clause_of(clausula_decima_setima_cessao_contrato_subcontratacao, contrato_ocs_028_2022).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_028_2022).
clause_of(clausula_decima_nona_alteracoes_contratuais, contrato_ocs_028_2022).
clause_of(clausula_vigésima_extincao_contrato, contrato_ocs_028_2022).
clause_of(clausula_vigésima_primeira_disposicoes_finais, contrato_ocs_028_2022).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_028_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_microsoft_365_licenses).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_microsoft_365_licenses).
legal_relation_instance(clausula_primeira_objeto, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_implementation_training_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_implementation_training_services).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, present_manifestation_about_extension).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, communicate_interest_in_extension_90_days).
legal_relation_instance(clausula_segunda_vigencia, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, be_subject_to_penalties_for_refusal_to_extend).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, communicate_interest_in_extension).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, execute_object_according_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution_according_specs).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_service_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, demand_indemnization).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_value).
legal_relation_instance(clausula_sexta_preco, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, bear_burdens_from_errors).
legal_relation_instance(clausula_sexta_preco, right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, receive_payment).
legal_relation_instance(clausula_sexta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reduce_values_proportionally).
legal_relation_instance(clausula_sexta_preco, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, execute_contract_subject).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, tax_retention).
legal_relation_instance(clausula_setima_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_late_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_tax_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, request_price_revision_before_contract_end).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, request_price_revision_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_revision_request).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, celebrate_additives).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, celebrate_additives).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, manage_allocated_risks).
legal_relation_instance(clausula_nona_matriz_riscos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, manage_allocated_risks).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, obtain_guarantor_approval).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_deadline).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, communicate_imposition_of_penalty).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, repair_correct_remove_reconstruct_or_substitute).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, repair_damages_to_bndes_or_third_parties).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, prove_regularity_when_required).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, assume_responsibility_for_charges).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_exclusion_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, obey_instructions_and_procedures).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, submit_information_declaration).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity_in_public_private_relations_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, take_measures_to_prevent_corruption).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, prevent_favoritism_employee_bndes).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, prevent_allocation_of_family_bndes_employees).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, observe_bndes_ethics_policies).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, remove_agents_causing_impediments).
legal_relation_instance(clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, communicate_incidents_to_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, comply_with_information_security_policy).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, not_access_confidential_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, maintain_confidentiality_of_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, copy_reproduce_retain_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, limit_access_to_information).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, deliver_material_at_end_of_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_omit, telsinc_comercio_de_equipamentos_de_informatica_ltda, use_confidential_info_after_contract).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, observe_confidentiality_term).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informacoes, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, access_confidential_information).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, assign_contract_or_credit).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, no_right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, obtain_bndes_approval_for_restructuring).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, maintain_contract_conditions_after_restructuring).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, obtain_bndes_approval_for_subcontracting).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, provide_documents_for_subcontracting).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, remain_responsible_for_subcontractor).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, present_confidentiality_terms).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, permission_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, undergo_corporate_restructuring).
legal_relation_instance(clausula_decima_setima_cessao_contrato_subcontratacao, permission_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, subcontract_implementation_training).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, telsinc_comercio_de_equipamentos_de_informatica_ltda, perform_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, telsinc_comercio_de_equipamentos_de_informatica_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, telsinc_comercio_de_equipamentos_de_informatica_ltda, request_reconsideration).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_by_agreement).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_due_to_refusal_to_alter).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages_refusal_to_alter).
legal_relation_instance(clausula_decima_nona_alteracoes_contratuais, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_contract_alteration_with_just_cause).
legal_relation_instance(clausula_vigésima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification).
legal_relation_instance(clausula_vigésima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_of_defense).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_if_contracted_party_bankrupt).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_if_contracted_party_loses_habilitation).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_illegal_act).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_dissolution).
legal_relation_instance(clausula_vigésima_extincao_contrato, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_force_majeure).
legal_relation_instance(clausula_vigésima_extincao_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_in_case_of_breach).
legal_relation_instance(clausula_vigésima_extincao_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_to_breach).
legal_relation_instance(clausula_vigésima_primeira_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_contractual_rights).
legal_relation_instance(clausula_vigésima_primeira_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_waiver_due_to_tolerance).
legal_relation_instance(clausula_vigésima_segunda_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_forum_rio_de_janeiro).
legal_relation_instance(clausula_vigésima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_outside_rio_de_janeiro).

% --- Action catalog (local to this contract grounding) ---
action_type(access_confidential_information).
action_label(access_confidential_information, 'No right to access').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(alter_contract_by_agreement).
action_label(alter_contract_by_agreement, 'Alter contract by agreement').
action_type(analyze_price_revision_request).
action_label(analyze_price_revision_request, 'Analyze price revision request').
action_type(answer_questions_and_clarifications).
action_label(answer_questions_and_clarifications, 'Answer questions and clarifications').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction').
action_type(assign_contract_or_credit).
action_label(assign_contract_or_credit, 'No right to assign contract').
action_type(assume_responsibility_for_charges).
action_label(assume_responsibility_for_charges, 'Assume responsibility for charges').
action_type(attend_transition_requests).
action_label(attend_transition_requests, 'Attend transition requests').
action_type(be_liable_for_damages_refusal_to_alter).
action_label(be_liable_for_damages_refusal_to_alter, 'Be liable for damages refusal to alter').
action_type(be_responsible_for_security_standards).
action_label(be_responsible_for_security_standards, 'Be responsible for security standards').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_penalties_for_refusal_to_extend).
action_label(be_subject_to_penalties_for_refusal_to_extend, 'Subject to penalties for refusal to extend').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Subject to price reduction').
action_type(bear_burdens_from_errors).
action_label(bear_burdens_from_errors, 'Bear burdens from errors').
action_type(celebrate_additives).
action_label(celebrate_additives, 'Do not celebrate additives').
action_type(claim_waiver_due_to_tolerance).
action_label(claim_waiver_due_to_tolerance, 'Claim waiver').
action_type(communicate_imposition_of_penalty).
action_label(communicate_imposition_of_penalty, 'Communicate penalty imposition').
action_type(communicate_incidents_to_bndes).
action_label(communicate_incidents_to_bndes, 'Communicate incidents to BNDES').
action_type(communicate_interest_in_extension).
action_label(communicate_interest_in_extension, 'Communicate interest in contract extension').
action_type(communicate_interest_in_extension_90_days).
action_label(communicate_interest_in_extension_90_days, 'Communicate interest in extension 90 days before end').
action_type(compensate_damages_due_to_refusal_to_alter).
action_label(compensate_damages_due_to_refusal_to_alter, 'Compensate damages due to refusal to alter').
action_type(comply_with_information_security_policy).
action_label(comply_with_information_security_policy, 'Comply with security policy').
action_type(configure_update_replace_functionalities).
action_label(configure_update_replace_functionalities, 'Configure update replace functionalities').
action_type(copy_reproduce_retain_information).
action_label(copy_reproduce_retain_information, 'Do not copy/reproduce/retain info').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deliver_material_at_end_of_contract).
action_label(deliver_material_at_end_of_contract, 'Deliver materials at contract end').
action_type(demand_execution_according_specs).
action_label(demand_execution_according_specs, 'Demand execution according to specs').
action_type(demand_indemnization).
action_label(demand_indemnization, 'Demand indemnization').
action_type(demand_service_standards).
action_label(demand_service_standards, 'Demand service standards').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(efetuar_recebimento_objeto).
action_label(efetuar_recebimento_objeto, 'Receive the object').
action_type(effectuate_payment).
action_label(effectuate_payment, 'Effectuate payment').
action_type(establish_forum_rio_de_janeiro).
action_label(establish_forum_rio_de_janeiro, 'Establish forum in Rio de Janeiro').
action_type(execute_contract_subject).
action_label(execute_contract_subject, 'Execute the contract object').
action_type(execute_object_according_specifications).
action_label(execute_object_according_specifications, 'Execute object according to specs').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services as per standards').
action_type(exercise_contractual_rights).
action_label(exercise_contractual_rights, 'Exercise contractual rights').
action_type(extend_guarantee_presentation_deadline).
action_label(extend_guarantee_presentation_deadline, 'Extend deadline for guarantee').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(guarantee_contract_does_not_infringe_rights).
action_label(guarantee_contract_does_not_infringe_rights, 'Guarantee no rights infringement').
action_type(issue_credit_title).
action_label(issue_credit_title, 'No right to issue credit title').
action_type(limit_access_to_information).
action_label(limit_access_to_information, 'Limit access to information').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain qualification conditions').
action_type(maintain_confidentiality_of_information).
action_label(maintain_confidentiality_of_information, 'Maintain confidentiality').
action_type(maintain_contract_conditions_after_restructuring).
action_label(maintain_contract_conditions_after_restructuring, 'Subject to maintaining contract conditions').
action_type(maintain_integrity_in_public_private_relations).
action_label(maintain_integrity_in_public_private_relations, 'Maintain integrity in relations').
action_type(maintain_integrity_in_public_private_relations_bndes).
action_label(maintain_integrity_in_public_private_relations_bndes, 'Maintain integrity in relations').
action_type(manage_allocated_risks).
action_label(manage_allocated_risks, 'Manage allocated risks').
action_type(not_access_confidential_information).
action_label(not_access_confidential_information, 'Do not access confidential info').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(notify_in_case_of_breach).
action_label(notify_in_case_of_breach, 'Notify breach').
action_type(obey_instructions_and_procedures).
action_label(obey_instructions_and_procedures, 'Obey instructions and procedures').
action_type(observe_bndes_ethics_policies).
action_label(observe_bndes_ethics_policies, 'Observe BNDES ethics policies').
action_type(observe_confidentiality_term).
action_label(observe_confidentiality_term, 'Observe confidentiality term').
action_type(obtain_bndes_approval_for_restructuring).
action_label(obtain_bndes_approval_for_restructuring, 'Subject to BNDES approval for restructuring').
action_type(obtain_bndes_approval_for_subcontracting).
action_label(obtain_bndes_approval_for_subcontracting, 'Subject to BNDES approval for subcontracting').
action_type(obtain_guarantor_approval).
action_label(obtain_guarantor_approval, 'Obtain guarantor\'s approval').
action_type(omit_contract_alteration_with_just_cause).
action_label(omit_contract_alteration_with_just_cause, 'Omit contract alteration with just cause').
action_type(pay_contracted_value).
action_label(pay_contracted_value, 'Pay the contracted value').
action_type(perform_contract).
action_label(perform_contract, 'Perform contract').
action_type(permit_inspections_and_monitoring).
action_label(permit_inspections_and_monitoring, 'Permit inspections').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_manifestation_about_extension).
action_label(present_manifestation_about_extension, 'Present manifestation about contract extension').
action_type(prevent_allocation_of_family_bndes_employees).
action_label(prevent_allocation_of_family_bndes_employees, 'Prevent allocation of BNDES employees family').
action_type(prevent_favoritism_employee_bndes).
action_label(prevent_favoritism_employee_bndes, 'Prevent BNDES employee favoritism').
action_type(prove_regularity_when_required).
action_label(prove_regularity_when_required, 'Prove regularity when required').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_documents_for_subcontracting).
action_label(provide_documents_for_subcontracting, 'Subject to providing subcontracting documents').
action_type(provide_exclusion_from_simples_nacional).
action_label(provide_exclusion_from_simples_nacional, 'Provide exclusion from Simples Nacional').
action_type(provide_implementation_training_services).
action_label(provide_implementation_training_services, 'Provide implementation and training services').
action_type(provide_microsoft_365_licenses).
action_label(provide_microsoft_365_licenses, 'Provide Microsoft 365 licenses').
action_type(provide_opportunity_of_defense).
action_label(provide_opportunity_of_defense, 'Provide opportunity of defense').
action_type(provide_tax_information).
action_label(provide_tax_information, 'Provide tax information').
action_type(provide_written_notification).
action_label(provide_written_notification, 'Provide written notification').
action_type(receive_implementation_training_services).
action_label(receive_implementation_training_services, 'Receive implementation and training services').
action_type(receive_microsoft_365_licenses).
action_label(receive_microsoft_365_licenses, 'Receive Microsoft 365 licenses').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(reduce_values_proportionally).
action_label(reduce_values_proportionally, 'Reduce values proportionally').
action_type(reject_late_fiscal_document).
action_label(reject_late_fiscal_document, 'Reject late fiscal document').
action_type(remain_responsible_for_subcontractor).
action_label(remain_responsible_for_subcontractor, 'Subject to responsibility for subcontractor').
action_type(remove_agents_causing_impediments).
action_label(remove_agents_causing_impediments, 'Remove agents causing impediments').
action_type(repair_correct_remove_reconstruct_or_substitute).
action_label(repair_correct_remove_reconstruct_or_substitute, 'Repair or replace defective objects').
action_type(repair_damages_to_bndes_or_third_parties).
action_label(repair_damages_to_bndes_or_third_parties, 'Repair damages to BNDES or third parties').
action_type(report_bugs_and_security_flaws).
action_label(report_bugs_and_security_flaws, 'Report bugs and security flaws').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revision_after_deadline).
action_label(request_price_revision_after_deadline, 'Cannot request revision after deadline').
action_type(request_price_revision_before_contract_end).
action_label(request_price_revision_before_contract_end, 'Request price revision before contract end').
action_type(request_reconsideration).
action_label(request_reconsideration, 'Request reconsideration').
action_type(resolve_problems_in_contracted_solution).
action_label(resolve_problems_in_contracted_solution, 'Resolve problems in contracted solution').
action_type(return_resources_and_revoke_access).
action_label(return_resources_and_revoke_access, 'Return resources and revoke access').
action_type(subcontract_implementation_training).
action_label(subcontract_implementation_training, 'Permission to subcontract').
action_type(submit_information_declaration).
action_label(submit_information_declaration, 'Submit Information Declaration').
action_type(sue_outside_rio_de_janeiro).
action_label(sue_outside_rio_de_janeiro, 'No right to sue outside Rio').
action_type(take_measures_to_prevent_corruption).
action_label(take_measures_to_prevent_corruption, 'Prevent corruption by agents').
action_type(tax_retention).
action_label(tax_retention, 'Subject to tax retention').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_after_suspension).
action_label(terminate_contract_after_suspension, 'Terminate after suspension').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_due_to_breach).
action_label(terminate_contract_due_to_breach, 'Terminate contract on breach').
action_type(terminate_contract_due_to_dissolution).
action_label(terminate_contract_due_to_dissolution, 'Terminate due to dissolution').
action_type(terminate_contract_due_to_force_majeure).
action_label(terminate_contract_due_to_force_majeure, 'Terminate due to force majeure').
action_type(terminate_contract_due_to_illegal_act).
action_label(terminate_contract_due_to_illegal_act, 'Terminate due to illegal act').
action_type(terminate_contract_if_bndes_fails_to_release_area).
action_label(terminate_contract_if_bndes_fails_to_release_area, 'Terminate if BNDES fails to release').
action_type(terminate_contract_if_contracted_party_bankrupt).
action_label(terminate_contract_if_contracted_party_bankrupt, 'Terminate if party bankrupt').
action_type(terminate_contract_if_contracted_party_loses_habilitation).
action_label(terminate_contract_if_contracted_party_loses_habilitation, 'Terminate if party loses habil').
action_type(undergo_corporate_restructuring).
action_label(undergo_corporate_restructuring, 'Permission for corporate restructuring').
action_type(undergo_inspections_and_monitoring).
action_label(undergo_inspections_and_monitoring, 'Undergo inspections').
action_type(use_confidential_info_after_contract).
action_label(use_confidential_info_after_contract, 'Do not use confidential info after contract').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_028_2022).
contract_metadata(contrato_ocs_028_2022, numero_ocs, '028/2022').
contract_metadata(contrato_ocs_028_2022, numero_sap, '4400004921').
contract_metadata(contrato_ocs_028_2022, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_028_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'TELSINC COMERCIO DE EQUIPAMENTOS DE INFORMATICA LTDA']).
contract_metadata(contrato_ocs_028_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_028_2022, contratado, 'TELSINC COMERCIO DE EQUIPAMENTOS DE INFORMATICA LTDA').
contract_metadata(contrato_ocs_028_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_028_2022, cnpj_contratado, '01.096.059/0001-98').
contract_metadata(contrato_ocs_028_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 001/2022 - BNDES').
contract_metadata(contrato_ocs_028_2022, data_autorizacao, '30/12/2021').
contract_metadata_raw(contrato_ocs_028_2022, 'ip_ati_deset', '025/2021', 'trecho_literal').
contract_metadata(contrato_ocs_028_2022, data_ip_ati_degat, '29/12/2021').
contract_metadata(contrato_ocs_028_2022, rubrica_orcamentaria, '3101700020').
contract_metadata(contrato_ocs_028_2022, rubrica_orcamentaria, '3101700040').
contract_metadata(contrato_ocs_028_2022, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_028_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_028_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_028_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a contratação de licenças de uso por subscrição da solução Microsoft 365 (E5 e telefones de uso compartilhado), e de serviços de implantação e treinamento, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 001/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 36 (trinta e seis) meses, a contar da data de sua assinatura, podendo ser prorrogado, mediante aditivo, por períodos sucessivos, até o limite total de 60 (sessenta) meses.  Parágrafo Primeiro O CONTRATADO deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Segundo Independente da notificação do parágrafo anterior, o CONTRATADO deverá comunicar ao Gestor seu interesse quanto à prorrogação do contrato até 90 (noventa) dias antes do término de cada período de vigência contratual.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura do CONTRATADO  Parágrafo Quarto Caso o CONTRATADO se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_028_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através da Comissão de Recebimento, mencionada na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de R$ 27.259.954,00 (vinte e sete milhões, duzentos e cinquenta e nove mil e novecentos e cinquenta e quatro reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis, a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pela Comissão de Recebimento do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O BNDES não efetuará pagamento diretamente em favor do(s) Subcontratado(s).   Parágrafo Sétimo O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Oitavo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Nono Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03. A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Décimo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Décimo Primeiro Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;  Parágrafo Décimo Segundo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Terceiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Quarto Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Quinto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_028_2022, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI do artigo 37 da Constituição Federal, a ser realizado mediante revisão de preços.  Parágrafo Primeiro Não haverá reajuste de preços, uma vez que, conforme a política comercial do fabricante da solução, licenças em contratos Enterprise Agreement Subscription (36 meses) possuem seus valores inalterados durante toda sua vigência, conforme informado no Termo de Referência, Anexo I ao Contrato. Parágrafo Segundo O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI do artigo 37 da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:  I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO com a comprovação da ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que:  I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_028_2022, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.    Parágrafo Único É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_028_2022, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 1.389.523,58 (hum milhão, trezentos e oitenta e nove mil, quinhentos e vinte e três reais e cinquenta e oito centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.   Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.    Parágrafo Segundo Havendo majoração do preço contratado, decorrente de revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis, a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_028_2022, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição, de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. apresentar, em até 10 (dez) dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; b) no caso de subcontratação, o CONTRATADO deverá apresentar, ainda, uma DIF para cada subcontratado, devidamente preenchida(s) com os respectivos dados e assinada(s) pelo(s) respectivo(s) representante(s) legal(is). XII. atender às solicitações do BNDES relativas à transição contratual entre o CONTRATADO e o seu sucessor na execução dos serviços, prestando todo o suporte, inclusive a capacitação dos profissionais de seu sucessor, a fim de que o objeto contratado não seja interrompido;  XIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIV. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos XV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência deste Contrato. XVI. Comunicar ao BNDES a descoberta de problemas, bugs, limitações e falhas de segurança, em qualquer componente da solução contratada e em tempos adequados à gravidade, segurança e disponibilidade dos serviços e das informações do BNDES; XVII. Responder a dúvidas e esclarecimentos relativos à utilização e configuração das funcionalidades e serviços do ambiente; XVIII. Resolver quaisquer problemas na solução contratada que limitem ou impeçam o seu funcionamento;  XIX. Configurar, atualizar e/ou substituir funcionalidades da solução contratada quando da constatação de falhas ou defeitos nestes itens;').
contract_clause(contrato_ocs_028_2022, clausula_decima_segunda_conduta_etica_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_028_2022, clausula_decima_terceira_sigilo_das_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Cabe ao CONTRATADO cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação dos serviços: I. cumprir as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES, necessárias para assegurar a integridade e o sigilo das informações;  II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação dos serviços objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato;  V. apresentar, antes do início da prestação dos serviços, Termos de Confidencialidade, conforme minutas constantes dos Anexos V e VI (Minuta de Termo de Confidencialidade para Profissionais e Minuta de Termo de confidencialidade para Subcontratação) deste Contrato, assinados pelos profissionais que acessarão informações sigilosas, devendo referida obrigação ser também cumprida por ocasião de substituição desses profissionais; e VI. observar o disposto no Termo de Confidencialidade assinado por seu Representante Legal constante do Anexo IV (Termo de Confidencialidade para Representante Legal) deste Contrato.').
contract_clause(contrato_ocs_028_2022, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:    I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação;  representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;  VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação;   VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados;  IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais;  XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas;  XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais;  XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada; de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.   Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei nº 13.709/2018 (Lei Geral de Proteção de Dados - LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.');
contract_clause(contrato_ocs_028_2022, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Diogo Santos Cardoso da Silva, que atualmente exerce a função de Gerente da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem estiver substituindo na função de Gerente; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.');
contract_clause(contrato_ocs_028_2022, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.');
contract_clause(contrato_ocs_028_2022, clausula_decima_setima_cessao_contrato_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato referente ao serviço de implantação, bem como ao serviço de treinamento, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação; e CONTRATADO apresentar, sempre que solicitado pelo BNDES, os respectivos documentos comprobatórios.  Parágrafo Quarto A subcontratação pode ser realizada com sociedades distintas e de forma simultânea, devendo, em todos os casos, ser relacionada à parcela do objeto autorizada pelo BNDES.  Parágrafo Quinto Caso o CONTRATADO opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da sociedade subcontratada.  Parágrafo Sexto Aceita, pelo BNDES, a subcontratação, o CONTRATADO deverá apresentar os Termos de Confidencialidade, conforme minuta constante do Anexo VI (Minuta de Termo de Confidencialidade para Subcontratação) deste Contrato, assinados pelo representante legal e pelos profissionais da sociedade subcontratada envolvidos na execução dos serviços subcontratados.', 'trecho_literal').
contract_clause(contrato_ocs_028_2022, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.   Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.    Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades previstas neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.', 'trecho_literal').
contract_clause(contrato_ocs_028_2022, clausula_decima_nona_alteracoes_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS  O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes de revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.', 'trecho_literal').
contract_clause(contrato_ocs_028_2022, clausula_vigésima_extincao_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO; e XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.', 'trecho_literal').
contract_clause(contrato_ocs_028_2022, clausula_vigésima_primeira_disposicoes_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 001/2022 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais Anexo VI - Minuta de Termo de Confidencialidade para Subcontratação  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.', 'trecho_literal').
contract_clause(contrato_ocs_028_2022, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO  É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste contrato foram conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, por autorização do representante legal que o assina.', 'trecho_literal').

% ===== END =====
